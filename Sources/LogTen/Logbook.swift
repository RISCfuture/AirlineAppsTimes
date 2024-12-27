import Foundation

public actor Logbook {
    
    // MARK: Data
    
    let aircraft: Array<Aircraft>
    let flights: Array<Flight>
    
    
    // MARK: Initializers
    
    init(aircraft: Array<Aircraft>,
         flights: Array<Flight>) {
        self.aircraft = Array(aircraft)
        self.flights = Array(flights)
    }
}
