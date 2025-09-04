import Foundation

protocol Formatter {
    func format(_ entry: TimeEntry) -> String
    func shouldIncludeAircraft(_ aircraft: AircraftType) -> Bool
}
