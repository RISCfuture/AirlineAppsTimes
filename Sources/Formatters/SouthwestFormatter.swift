import Foundation

/// Formats flight times for Southwest Airlines applications.
///
/// This formatter filters to turbine-powered airplanes only and outputs:
/// - **Date last flown**: Most recent flight in this aircraft type
/// - **PIC time**: Pilot in Command time
/// - **SIC time**: Second in Command time
/// - **Total time**: PIC + SIC (excludes dual given/received)
/// - **Total time last 36 months**: Rolling 36-month PIC + SIC total
///
/// ## Aircraft Filtering
///
/// Only includes aircraft meeting both criteria:
/// - Category: Airplane
/// - Engine type: Turbine, turbo-prop, turbo-fan, turbojet, or jet
///
/// ## Example Output
///
/// ```
/// B737
///   Date last flown: 12/1/24
///   PIC time: 1250.0
///   SIC time: 500.0
///   Total time: 1750.0
///   Total time last 36 months: 850.0
/// ```
struct SouthwestFormatter: Formatter {
  private static var timeFormatter: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 1
    formatter.minimumFractionDigits = 1
    formatter.usesGroupingSeparator = false
    return formatter
  }

  private static var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
  }

  private static let defaultFormatted = String(localized: "0.0")

  private static let validEngineTypes = [
    "turbine",
    "turbo-prop",
    "turbo-fan",
    "turbojet",
    "jet"
  ]

  func format(_ entry: TimeEntry) -> String {
    let formattedPIC =
      Self.timeFormatter.string(from: .init(floatLiteral: entry.PIC)) ?? Self.defaultFormatted
    let formattedSIC =
      Self.timeFormatter.string(from: .init(floatLiteral: entry.SIC)) ?? Self.defaultFormatted
    // For Southwest, total time is only PIC + SIC (no dual received or given)
    let totalTime = entry.PIC + entry.SIC
    let formattedTotal =
      Self.timeFormatter.string(from: .init(floatLiteral: totalTime)) ?? Self.defaultFormatted
    let formattedTotal36Months =
      Self.timeFormatter.string(from: .init(floatLiteral: entry.picPlusSicLast36Months))
      ?? Self.defaultFormatted

    let dateLastFlown = entry.dateLastFlown.map { Self.dateFormatter.string(from: $0) } ?? "N/A"

    return String(
      localized: """
        \(entry.type)
          Date last flown: \(dateLastFlown)
          PIC time: \(formattedPIC)
          SIC time: \(formattedSIC)
          Total time: \(formattedTotal)
          Total time last 36 months: \(formattedTotal36Months)
        """
    )
  }

  func shouldIncludeAircraft(_ aircraft: AircraftType) -> Bool {
    guard aircraft.aircraftCategory?.lowercased() == "airplane" else {
      return false
    }

    return Self.validEngineTypes.contains { engineType in
      aircraft.engineType?.lowercased() == engineType.lowercased()
    }
  }
}
