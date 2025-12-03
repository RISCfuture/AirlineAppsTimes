import Foundation

/// Formats flight times for AirlineApps.com applications.
///
/// This formatter outputs all aircraft types with the following fields:
/// - **PIC**: Pilot in Command time
/// - **D/G**: Dual Given (instruction provided)
/// - **SIC**: Second in Command time
/// - **D/R**: Dual Received (instruction received)
/// - **TT**: Total Time
///
/// All times are displayed with one decimal place.
///
/// ## Example Output
///
/// ```
/// B737
///   PIC: 1250.0
///   D/G: 125.0
///   SIC: 500.0
///   D/R: 0.0
///   TT:  1875.0
/// ```
struct AirlineAppsFormatter: Formatter {
  private static var timeFormatter: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 1
    formatter.minimumFractionDigits = 1
    formatter.usesGroupingSeparator = false
    return formatter
  }

  private static let defaultFormatted = String(localized: "0.0")

  func format(_ entry: TimeEntry) -> String {
    let formattedPIC =
      Self.timeFormatter.string(from: .init(floatLiteral: entry.PIC)) ?? Self.defaultFormatted
    let formattedSIC =
      Self.timeFormatter.string(from: .init(floatLiteral: entry.SIC)) ?? Self.defaultFormatted
    let formattedDualGiven =
      Self.timeFormatter.string(from: .init(floatLiteral: entry.dualGiven)) ?? Self.defaultFormatted
    let formattedDualReceived =
      Self.timeFormatter.string(from: .init(floatLiteral: entry.dualReceived))
      ?? Self.defaultFormatted
    let formattedTotal =
      Self.timeFormatter.string(from: .init(floatLiteral: entry.total)) ?? Self.defaultFormatted

    return String(
      localized: """
        \(entry.type)
          PIC: \(formattedPIC)
          D/G: \(formattedDualGiven)
          SIC: \(formattedSIC)
          D/R: \(formattedDualReceived)
          TT:  \(formattedTotal)
        """
    )
  }

  func shouldIncludeAircraft(_: AircraftType) -> Bool {
    true
  }
}
