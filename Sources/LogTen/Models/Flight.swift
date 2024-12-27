import Foundation

struct Flight: Record {
    
    // MARK: Properties
    
    let aircraft: Aircraft?
    
    let totalTime: UInt // minutes
    let PICTime: UInt // minutes
    let SICTime: UInt // minutes
    let dualGivenTime: UInt // minutes
    let dualReceivedTime: UInt // minutes
    
    
    // MARK: Computed Properties

    var totalHours: Double { Double(totalTime)/60 }
    var PICHours: Double { Double(PICTime)/60 }
    var SICHours: Double { Double(SICTime)/60 }
    var dualGivenHours: Double { Double(dualGivenTime)/60 }
    var dualReceivedHours: Double { Double(dualReceivedTime)/60 }
    
    // MARK: Initializers
    
    init(flight: CNFlight,
         aircraft: Aircraft) {
        self.aircraft = aircraft
        
        totalTime = flight.flight_totalTime?.uintValue ?? 0
        SICTime = flight.flight_sic?.uintValue ?? 0
        dualGivenTime = flight.flight_dualGiven?.uintValue ?? 0
        dualReceivedTime = flight.flight_dualReceived?.uintValue ?? 0
        
        var PICTime = flight.flight_pic?.uintValue ?? 0
        if dualGivenTime > 0 && PICTime > 0 { PICTime -= dualGivenTime }
        self.PICTime = PICTime
    }
}
