struct AircraftType: IdentifiableRecord {

  // MARK: Properties

  let id: String
  let typeCode: String
  let make: String
  let model: String
  let aircraftCategory: String?
  let aircraftClass: String?
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
