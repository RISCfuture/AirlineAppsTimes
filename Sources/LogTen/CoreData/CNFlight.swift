import Foundation
import CoreData

@objc(CNFlight)
final class CNFlight: NSManagedObject {
    
    // MARK: Fetch Request
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<CNFlight> {
        let request = NSFetchRequest<CNFlight>(entityName: "Flight")
        request.includesSubentities = true
        return request
    }
    
    // MARK: Managed Properties
    
    @NSManaged var flight_aircraft: CNAircraft?
    
    @NSManaged var flight_totalTime: NSNumber?
    @NSManaged var flight_pic: NSNumber?
    @NSManaged var flight_sic: NSNumber?
    @NSManaged var flight_dualGiven: NSNumber?
    @NSManaged var flight_dualReceived: NSNumber?
}
