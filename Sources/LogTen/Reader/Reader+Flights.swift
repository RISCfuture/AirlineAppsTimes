import Foundation
import CoreData

fileprivate let nightFullStopField = "Night Full Stops"
fileprivate let proficiencyField = "FAR 61.58"
fileprivate let checkrideField = "Checkride"

fileprivate let safetyPilotField = "Safety Pilot"
fileprivate let examinerField = "Examiner"

extension Reader {
    func fetchFlights(aircraft: Array<Aircraft>) throws -> Array<Flight> {
        let request = CNFlight.fetchRequest()
        let flights = try container.viewContext.fetch(request)
        
        return flights.compactMap { flight in
            guard let aircraft = aircraft.first(where: { $0.tailNumber == flight.flight_aircraft?.aircraft_aircraftID }) else {
                return nil
            }
            return .init(flight: flight, aircraft: aircraft)
        }
    }
}
