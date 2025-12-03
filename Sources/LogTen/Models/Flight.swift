import Foundation

/// A single flight record from the LogTen Pro database.
///
/// Each `Flight` represents one logged flight with its associated
/// aircraft and time breakdowns. Times are stored internally in minutes
/// but exposed as hours through computed properties.
struct Flight: Record {

  // MARK: Properties

  /// The aircraft used for this flight.
  let aircraft: Aircraft?

  /// The date of the flight.
  let flightDate: Date?

  /// Total flight time in minutes.
  let totalTime: UInt

  /// Pilot in Command time in minutes.
  let PICTime: UInt

  /// Second in Command time in minutes.
  let SICTime: UInt

  /// Dual given (instruction provided) time in minutes.
  let dualGivenTime: UInt

  /// Dual received (instruction received) time in minutes.
  let dualReceivedTime: UInt

  // MARK: Computed Properties

  /// Total flight time in hours.
  var totalHours: Double { Double(totalTime) / 60 }

  /// Pilot in Command time in hours.
  var PICHours: Double { Double(PICTime) / 60 }

  /// Second in Command time in hours.
  var SICHours: Double { Double(SICTime) / 60 }

  /// Dual given time in hours.
  var dualGivenHours: Double { Double(dualGivenTime) / 60 }

  /// Dual received time in hours.
  var dualReceivedHours: Double { Double(dualReceivedTime) / 60 }

  // MARK: Initializers

  init(
    flight: CNFlight,
    aircraft: Aircraft
  ) {
    self.aircraft = aircraft
    self.flightDate = flight.flight_flightDate

    totalTime = flight.flight_totalTime?.uintValue ?? 0
    SICTime = flight.flight_sic?.uintValue ?? 0
    dualGivenTime = flight.flight_dualGiven?.uintValue ?? 0
    dualReceivedTime = flight.flight_dualReceived?.uintValue ?? 0

    var PICTime = flight.flight_pic?.uintValue ?? 0
    if dualGivenTime > 0 && PICTime > 0 { PICTime -= dualGivenTime }
    self.PICTime = PICTime
  }
}
