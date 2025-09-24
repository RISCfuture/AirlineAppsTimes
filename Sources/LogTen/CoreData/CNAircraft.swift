import CoreData
import Foundation

@objc(CNAircraft)
final class CNAircraft: NSManagedObject {

  // MARK: Managed Properties

  @NSManaged var aircraft_aircraftType: CNAircraftType
  @NSManaged var aircraft_aircraftID: String

  // MARK: Fetch Request

  @nonobjc
  static func fetchRequest() -> NSFetchRequest<CNAircraft> {
    let request = NSFetchRequest<CNAircraft>(entityName: "Aircraft")
    request.sortDescriptors = [
      .init(keyPath: \CNAircraft.aircraft_aircraftID, ascending: true)  // swiftlint:disable:this prefer_self_in_static_references
    ]
    request.includesSubentities = true
    return request
  }
}
