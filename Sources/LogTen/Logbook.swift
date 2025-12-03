import Foundation

/// Container for flight data loaded from a LogTen Pro database.
///
/// A `Logbook` holds all aircraft and flight records read from the LogTen Pro
/// database. It's created by ``Reader`` when reading the database.
///
/// The data is immutable once loaded. The actor isolation ensures
/// thread-safe access to the flight data.
public actor Logbook {

  // MARK: Data

  /// All aircraft in the logbook.
  let aircraft: [Aircraft]

  /// All flight records in the logbook.
  let flights: [Flight]

  // MARK: Initializers

  init(
    aircraft: [Aircraft],
    flights: [Flight]
  ) {
    self.aircraft = Array(aircraft)
    self.flights = Array(flights)
  }
}
