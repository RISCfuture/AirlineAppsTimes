import Foundation

class TimeEntry: Identifiable, Hashable, Comparable {
    private static var timeFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 1
        formatter.usesGroupingSeparator = false
        return formatter
    }

    private static let defaultFormatted = String(localized: "0.0")

    private var formattedPIC: String { Self.timeFormatter.string(from: .init(floatLiteral: PIC)) ?? Self.defaultFormatted }
    private var formattedSIC: String { Self.timeFormatter.string(from: .init(floatLiteral: SIC)) ?? Self.defaultFormatted }
    private var formattedDualGiven: String { Self.timeFormatter.string(from: .init(floatLiteral: dualGiven)) ?? Self.defaultFormatted }
    private var formattedDualReceived: String { Self.timeFormatter.string(from: .init(floatLiteral: dualReceived)) ?? Self.defaultFormatted }
    private var formattedTotal: String { Self.timeFormatter.string(from: .init(floatLiteral: total)) ?? Self.defaultFormatted }

    let type: String
    var PIC: Double
    var SIC: Double
    var dualGiven: Double
    var dualReceived: Double
    var total: Double

    var id: String { type }

    var output: String {
        String(localized: """
               \(type)
                 PIC: \(formattedPIC)
                 D/G: \(formattedDualGiven)
                 SIC: \(formattedSIC)
                 D/R: \(formattedDualReceived)
                 TT:  \(formattedTotal)
               """)
    }

    init(flight: Flight) {
        guard let typeCode = flight.aircraft?.type.typeCode else {
            preconditionFailure("typeCode must not be nil")
        }

        type = typeCode
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
