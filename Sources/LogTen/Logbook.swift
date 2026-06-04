import Foundation

/// Container for flight data loaded from a LogTen Pro database.
///
/// A `Logbook` holds all flight records read from the LogTen Pro database. It's
/// created by ``Reader`` when reading the database.
///
/// The data is immutable once loaded. The actor isolation ensures
/// thread-safe access to the flight data.
public actor Logbook {

  // MARK: Data

  /// All flight records in the logbook.
  let flights: [Flight]

  // MARK: Initializers

  init(flights: [Flight]) {
    self.flights = Array(flights)
  }
}
