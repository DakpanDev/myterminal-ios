//
//  DetailsUIMapper.swift
//  MyTerminal
//
//  Created by Mitchell Tol on 03/03/2025.
//

import Foundation

final class DetailsUIMapper {
    
    func mapFlightToDetails(flight: Flight) -> DetailsUIModel {
        let states: [FlightStatus] = if let flightStates = flight.states {
            flightStates.map(self.mapStateToFlightStatus)
        } else {
            []
        }
        
        return DetailsUIModel(
            id: flight.id,
            name: flight.name,
            destination: flight.destination,
            states: states,
            departureDateTime: flight.departureDateTime,
            terminal: flight.terminal,
            checkinRows: flight.checkinRows ?? [],
            gate: flight.gate,
            checkinClosingTime: flight.checkinClosingTime,
            gateOpeningTime: flight.gateOpeningTime,
            boardingTime: flight.boardingTime,
            actualDepartureTime: flight.actualDeparturetime,
            lastUpdated: flight.lastUpdated,
            isBookmarked: flight.isBookmarked
        )
    }
    
    private func mapStateToFlightStatus(_ state: String) -> FlightStatus {
        return switch (state) {
        case DetailsUIMapper.FlightScheduled: .scheduled
        case DetailsUIMapper.Delayed: .delayed
        case DetailsUIMapper.WaitInLounge: .waitinlounge
        case DetailsUIMapper.GateOpen: .gateopen
        case DetailsUIMapper.Boarding: .boarding
        case DetailsUIMapper.GateClosing: .gateclosing
        case DetailsUIMapper.GateClosed: .gateclosed
        case DetailsUIMapper.Departed: .departed
        case DetailsUIMapper.Cancelled: .cancelled
        case DetailsUIMapper.GateChange: .gatechange
        case DetailsUIMapper.Tomorrow: .tomorrow
        default: .unknown
        }
    }
    
    static let FlightScheduled = "SCH"
    static let Delayed = "DEL"
    static let WaitInLounge = "WIL"
    static let GateOpen = "GTO"
    static let Boarding = "BRD"
    static let GateClosing = "GCL"
    static let GateClosed = "GTD"
    static let Departed = "DEP"
    static let Cancelled = "CNX"
    static let GateChange = "GCH"
    static let Tomorrow = "TOM"
}
