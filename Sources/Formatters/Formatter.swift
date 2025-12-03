import Foundation

/// A protocol for formatting flight time entries for output.
///
/// Formatters convert ``TimeEntry`` data into human-readable strings
/// suitable for airline applications. Different formatters may include
/// different fields and filter aircraft types differently.
///
/// ## Conforming Types
///
/// - ``AirlineAppsFormatter``: For AirlineApps.com applications
/// - ``SouthwestFormatter``: For Southwest Airlines applications
///
/// ## See Also
///
/// - <doc:OutputFormats>
protocol Formatter {
  /// Formats a time entry for display.
  ///
  /// - Parameter entry: The aggregated flight time data to format.
  /// - Returns: A formatted string representation of the time entry.
  func format(_ entry: TimeEntry) -> String

  /// Determines whether an aircraft type should be included in output.
  ///
  /// Some formats filter aircraft types. For example, Southwest format
  /// only includes turbine-powered airplanes.
  ///
  /// - Parameter aircraft: The aircraft type to check.
  /// - Returns: `true` if this aircraft type should be included in output.
  func shouldIncludeAircraft(_ aircraft: AircraftType) -> Bool
}
