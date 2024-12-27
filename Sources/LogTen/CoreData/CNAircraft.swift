import Foundation
import CoreData

@objc(CNAircraft)
final class CNAircraft: NSManagedObject {
    
    // MARK: Fetch Request
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<CNAircraft> {
        let request = NSFetchRequest<CNAircraft>(entityName: "Aircraft")
        request.sortDescriptors = [
            .init(keyPath: \CNAircraft.aircraft_aircraftID, ascending: true)
        ]
        request.includesSubentities = true
        return request
    }
    
    // MARK: Managed Properties
    
    @NSManaged var aircraft_aircraftType: CNAircraftType
    @NSManaged var aircraft_aircraftID: String
}
