import Foundation

struct Aircraft: IdentifiableRecord {
    
    // MARK: Properties
    
    let type: AircraftType
    let tailNumber: String
    var id: String { tailNumber }
    
    // MARK: Initializers
    
    init(aircraft: CNAircraft,
         typeCodeProperty: KeyPath<CNAircraftType, String?>) {
        type = .init(aircraftType: aircraft.aircraft_aircraftType,
                     typeCodeProperty: typeCodeProperty)
        tailNumber = aircraft.aircraft_aircraftID
    }
}
