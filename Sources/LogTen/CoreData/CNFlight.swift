import CoreData
import Foundation

@objc(CNFlight)
final class CNFlight: NSManagedObject {

    // MARK: Managed Properties

    @NSManaged var flight_aircraft: CNAircraft?
    @NSManaged var flight_flightDate: Date?

    @NSManaged var flight_totalTime: NSNumber?
    @NSManaged var flight_pic: NSNumber?
    @NSManaged var flight_sic: NSNumber?
    @NSManaged var flight_dualGiven: NSNumber?
    @NSManaged var flight_dualReceived: NSNumber?

    // MARK: Fetch Request

    @nonobjc
    static func fetchRequest() -> NSFetchRequest<CNFlight> {
        let request = NSFetchRequest<CNFlight>(entityName: "Flight")
        request.includesSubentities = true
        return request
    }
}
