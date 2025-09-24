import Foundation

class TimeEntry: Identifiable, Hashable, Comparable {
  private var flights: [Flight] = []

  let type: String
  var PIC: Double = 0
  var SIC: Double = 0
  var dualGiven: Double = 0
  var dualReceived: Double = 0
  var total: Double = 0

  var dateLastFlown: Date? {
    flights.compactMap(\.flightDate).max()
  }

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
