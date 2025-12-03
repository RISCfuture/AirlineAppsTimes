import Foundation

/// Aggregated flight time data for a single aircraft type.
///
/// A `TimeEntry` accumulates flight hours across all flights for a particular
/// aircraft type code (e.g., "B737", "C172"). It tracks various time categories
/// and provides rolling calculations for recent flight activity.
///
/// ## Example
///
/// The tool creates `TimeEntry` instances automatically by grouping flights:
///
/// ```
/// B737
///   PIC: 1250.0
///   SIC: 500.0
///   Total: 1875.0
/// ```
class TimeEntry: Identifiable, Hashable, Comparable {
  private var flights: [Flight] = []

  /// The aircraft type code (e.g., "B737", "C172", "PA28").
  let type: String

  /// Total Pilot in Command time in hours.
  var PIC: Double = 0

  /// Total Second in Command time in hours.
  var SIC: Double = 0

  /// Total dual given (instruction provided) time in hours.
  var dualGiven: Double = 0

  /// Total dual received (instruction received) time in hours.
  var dualReceived: Double = 0

  /// Total flight time in hours across all categories.
  var total: Double = 0

  /// The most recent flight date for this aircraft type.
  ///
  /// Returns `nil` if no flights have recorded dates.
  var dateLastFlown: Date? {
    flights.compactMap(\.flightDate).max()
  }

  /// Total flight time in the last 36 months.
  ///
  /// Calculates the sum of all flight time (total hours) for flights
  /// within the last 36 months from the current date.
  var totalLast36Months: Double {
    let cutoffDate = Calendar.current.date(byAdding: .month, value: -36, to: Date()) ?? Date()
    return
      flights
      .filter { flight in
        guard let flightDate = flight.flightDate else { return false }
        return flightDate >= cutoffDate
      }
      .reduce(0) { $0 + $1.totalHours }
  }

  /// Combined PIC and SIC time in the last 36 months.
  ///
  /// Used by Southwest format to show recent turbine time.
  /// Does not include dual given or dual received.
  var picPlusSicLast36Months: Double {
    let cutoffDate = Calendar.current.date(byAdding: .month, value: -36, to: Date()) ?? Date()
    return
      flights
      .filter { flight in
        guard let flightDate = flight.flightDate else { return false }
        return flightDate >= cutoffDate
      }
      .reduce(0) { $0 + $1.PICHours + $1.SICHours }
  }

  /// The unique identifier, which is the aircraft type code.
  var id: String { type }

  init(flight: Flight) {
    guard let typeCode = flight.aircraft?.type.typeCode else {
      preconditionFailure("typeCode must not be nil")
    }

    type = typeCode
    flights = [flight]
    total = flight.totalHours
    PIC = flight.PICHours
    SIC = flight.SICHours
    dualGiven = flight.dualGivenHours
    dualReceived = flight.dualReceivedHours
  }

  static func < (lhs: TimeEntry, rhs: TimeEntry) -> Bool {
    lhs.total < rhs.total
  }

  static func == (lhs: TimeEntry, rhs: TimeEntry) -> Bool {
    lhs.type == rhs.type
  }

  func addFlight(_ flight: Flight) {
    precondition(flight.aircraft?.type.typeCode == type)

    flights.append(flight)
    total += flight.totalHours
    PIC += flight.PICHours
    SIC += flight.SICHours
    dualGiven += flight.dualGivenHours
    dualReceived += flight.dualReceivedHours
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
