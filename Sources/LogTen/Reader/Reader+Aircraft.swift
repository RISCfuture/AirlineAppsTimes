private let typeCodeField = "Type Code"
private let simTypeField = "Sim Type"
private let simCategoryField = "Sim A/C Cat"
private let dieselField = "Diesel Engine"

extension Reader {
    func fetchAircraft() throws -> [Aircraft] {
        let request = CNAircraft.fetchRequest()
        let aircraft = try container.viewContext.fetch(request)

        let typeCodeProperty = try aircraftTypeCustomAttribute(for: typeCodeField)

        return aircraft.map { aircraft in
                .init(aircraft: aircraft, typeCodeProperty: typeCodeProperty)
        }
    }

    private func aircraftTypeCustomAttribute(for title: String) throws -> KeyPath<CNAircraftType, String?> {
        let request = CNLogTenCustomizationProperty.fetchRequest(title: title, keyPrefix: "aircraftType_customAttribute")
        let result = try container.viewContext.fetch(request)
        guard result.count == 1, let property = result.first else {
            throw Errors.missingProperty(title, model: "Aircraft Type")
        }
        switch property.logTenProperty_key {
            case "aircraftType_customAttribute1": return \.aircraftType_customAttribute1
            case "aircraftType_customAttribute2": return \.aircraftType_customAttribute2
            case "aircraftType_customAttribute3": return \.aircraftType_customAttribute3
            case "aircraftType_customAttribute4": return \.aircraftType_customAttribute4
            case "aircraftType_customAttribute5": return \.aircraftType_customAttribute5
            default: preconditionFailure("Unknown custom attribute \(property.logTenProperty_key)")
        }
    }
}
