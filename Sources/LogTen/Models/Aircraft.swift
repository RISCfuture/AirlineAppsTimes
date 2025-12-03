import Foundation

/// An aircraft from the LogTen Pro database.
///
/// Each `Aircraft` represents a specific tail number with its
/// associated aircraft type information.
struct Aircraft: IdentifiableRecord {

  // MARK: Properties

  /// The type of aircraft (make, model, category, etc.).
  let type: AircraftType

  /// The aircraft registration/tail number (e.g., "N12345").
  let tailNumber: String

  /// The unique identifier, which is the tail number.
  var id: String { tailNumber }

  // MARK: Initializers

  init(
    aircraft: CNAircraft,
    typeCodeProperty: KeyPath<CNAircraftType, String?>
  ) {
    type = .init(
      aircraftType: aircraft.aircraft_aircraftType,
      typeCodeProperty: typeCodeProperty
    )
    tailNumber = aircraft.aircraft_aircraftID
  }
}
