import CoreData
import Foundation

/// Reads flight data from a LogTen Pro database.
///
/// The `Reader` actor handles Core Data initialization and fetching
/// of aircraft and flight records from the LogTen Pro SQLite database.
///
/// ## Usage
///
/// ```swift
/// let reader = try await Reader(storeURL: databaseURL, modelURL: modelURL)
/// let logbook = try reader.read()
/// ```
///
/// The reader opens the database in read-only mode to avoid any
/// modifications to your logbook data.
actor Reader {
  let container: NSPersistentContainer

  /// Creates a reader for the specified LogTen Pro database.
  ///
  /// - Parameters:
  ///   - storeURL: Path to the LogTenCoreDataStore.sql file.
  ///   - modelURL: Path to the CNLogBookDocument.momd directory.
  /// - Throws: ``Errors/couldntCreateStore(path:)`` if the database cannot be opened.
  init(storeURL: URL, modelURL: URL) async throws {
    guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
      throw Errors.couldntCreateStore(path: modelURL)
    }
    container = NSPersistentContainer(name: "LogTen Pro", managedObjectModel: managedObjectModel)

    let store = NSPersistentStoreDescription(url: storeURL)
    store.setOption(NSNumber(value: true), forKey: NSReadOnlyPersistentStoreOption)
    store.setOption(["journal_mode": "DELETE"] as NSObject, forKey: NSSQLitePragmasOption)

    try await withCheckedThrowingContinuation {
      (continuation: CheckedContinuation<Void, Swift.Error>) in
      container.persistentStoreDescriptions = [store]
      container.loadPersistentStores { _, error in
        if let error {
          continuation.resume(throwing: error)
        } else {
          continuation.resume(returning: ())
        }
      }
    }
  }

  /// Reads all aircraft and flights from the database.
  ///
  /// - Returns: A ``Logbook`` containing all aircraft and flight records.
  /// - Throws: Core Data errors if the fetch fails.
  func read() throws -> Logbook {
    let aircraft = try fetchAircraft()
    let flights = try fetchFlights(aircraft: aircraft)

    return .init(aircraft: aircraft, flights: flights)
  }
}
