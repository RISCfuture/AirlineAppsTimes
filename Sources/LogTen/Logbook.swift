import Foundation

/// Represents a LogTen Pro logbook.
public actor Logbook {

    // MARK: Data

    let aircraft: [Aircraft]
    let flights: [Flight]

    // MARK: Initializers

    init(aircraft: [Aircraft],
         flights: [Flight]) {
        self.aircraft = Array(aircraft)
        self.flights = Array(flights)
    }
}
