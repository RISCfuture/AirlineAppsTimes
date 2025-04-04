struct AircraftType: IdentifiableRecord {

    // MARK: Properties

    let id: String
    let typeCode: String
    let make: String
    let model: String

    // MARK: Initializers

    init(aircraftType: CNAircraftType,
         typeCodeProperty: KeyPath<CNAircraftType, String?>) {

        id = aircraftType.aircraftType_type
        typeCode = aircraftType[keyPath: typeCodeProperty] ?? aircraftType.aircraftType_type
        make = aircraftType.aircraftType_make
        model = aircraftType.aircraftType_model
    }
}
