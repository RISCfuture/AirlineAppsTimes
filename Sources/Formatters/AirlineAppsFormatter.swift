import Foundation

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
