import CoreData
import Foundation

private let nightFullStopField = "Night Full Stops"
private let proficiencyField = "FAR 61.58"
private let checkrideField = "Checkride"

private let safetyPilotField = "Safety Pilot"
private let examinerField = "Examiner"

extension Reader {
    func fetchFlights(aircraft: [Aircraft]) throws -> [Flight] {
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
