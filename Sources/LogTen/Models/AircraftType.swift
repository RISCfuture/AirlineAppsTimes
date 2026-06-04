/// An aircraft type definition from the LogTen Pro database.
///
/// `AircraftType` contains the type code and classification
/// information for a type of aircraft. This data is used for
/// grouping flights and filtering by category/engine type.
struct AircraftType: IdentifiableRecord {

  // MARK: Properties

  /// Internal identifier from LogTen Pro.
  let id: String

  /// The aircraft type code used for grouping (e.g., "B737", "C172").
  let typeCode: String

  /// The aircraft category (e.g., "Airplane", "Helicopter", "Glider").
  ///
  /// Used by ``SouthwestFormatter`` to filter to airplanes only.
  let aircraftCategory: String?

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

    // Extract the string values from the property objects
    aircraftCategory = aircraftType.aircraftType_category?.logTenCustomizationProperty_title
    engineType = aircraftType.aircraftType_engineType?.logTenCustomizationProperty_title
  }
}
