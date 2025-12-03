/// An aircraft type definition from the LogTen Pro database.
///
/// `AircraftType` contains the make, model, and classification
/// information for a type of aircraft. This data is used for
/// grouping flights and filtering by category/engine type.
struct AircraftType: IdentifiableRecord {

  // MARK: Properties

  /// Internal identifier from LogTen Pro.
  let id: String

  /// The aircraft type code used for grouping (e.g., "B737", "C172").
  let typeCode: String

  /// The aircraft manufacturer (e.g., "Boeing", "Cessna").
  let make: String

  /// The aircraft model (e.g., "737-800", "172S").
  let model: String

  /// The aircraft category (e.g., "Airplane", "Helicopter", "Glider").
  ///
  /// Used by ``SouthwestFormatter`` to filter to airplanes only.
  let aircraftCategory: String?

  /// The aircraft class (e.g., "Single-Engine Land", "Multi-Engine Land").
  let aircraftClass: String?

  /// The engine type (e.g., "Piston", "Turbine", "Jet").
  ///
  /// Used by ``SouthwestFormatter`` to filter to turbine aircraft.
  let engineType: String?

  // MARK: Initializers

  init(
    aircraftType: CNAircraftType,
    typeCodeProperty: KeyPath<CNAircraftType, String?>
  ) {

    id = aircraftType.aircraftType_type
    typeCode = aircraftType[keyPath: typeCodeProperty] ?? aircraftType.aircraftType_type
    make = aircraftType.aircraftType_make
    model = aircraftType.aircraftType_model

    // Extract the string values from the property objects
    aircraftCategory = aircraftType.aircraftType_category?.logTenCustomizationProperty_title
    aircraftClass = aircraftType.aircraftType_aircraftClass?.logTenCustomizationProperty_title
    engineType = aircraftType.aircraftType_engineType?.logTenCustomizationProperty_title
  }
}
