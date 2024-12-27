import Foundation
import CoreData

actor Reader {
    let container: NSPersistentContainer
    
    init(storeURL: URL, modelURL: URL) async throws {
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            throw Errors.couldntCreateStore(path: modelURL)
        }
        container = NSPersistentContainer(name: "LogTen Pro", managedObjectModel: managedObjectModel)
        
        let store = NSPersistentStoreDescription(url: storeURL)
        store.setOption(NSNumber(booleanLiteral: true), forKey: NSReadOnlyPersistentStoreOption)
        store.setOption(["journal_mode": "DELETE"] as NSObject, forKey: NSSQLitePragmasOption)
        
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Swift.Error>) in
            container.persistentStoreDescriptions = [store]
            container.loadPersistentStores { descriptions, error in
                if let error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: ())
                }
            }
        }
    }
    
    func read() async throws -> Logbook {
        let aircraft = try fetchAircraft()
        let flights = try fetchFlights(aircraft: aircraft)

        return .init(aircraft: aircraft, flights: flights)
    }
}
