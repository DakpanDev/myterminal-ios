//
//  Flight.swift
//  Domain
//
//  Created by Mitchell Tol on 25/02/2025.
//

import Foundation

struct Flight {
    let id: String
    let name: String
    let destination: String
    let states: [String]?
    let departureDateTime: Date
    let terminal: Int?
    let checkinRows: [String]?
    let gate: String?
    let checkinClosingTime: Date?
    let gateOpeningTime: Date?
    let boardingTime: Date?
    let actualDeparturetime: Date?
    let lastUpdated: Date
    let isBookmarked: Bool
    
    func copy(
        id: String? = nil,
        name: String? = nil,
        destination: String? = nil,
        states: [String]? = nil,
        departureDateTime: Date? = nil,
        terminal: Int? = nil,
        checkinRows: [String]? = nil,
        gate: String? = nil,
        checkinClosingTime: Date? = nil,
        gateOpeningTime: Date? = nil,
        boardingTime: Date? = nil,
        actualDeparturetime: Date? = nil,
        lastUpdated: Date? = nil,
        isBookmarked: Bool? = nil
    ) -> Flight {
        return Flight(
            id: id ?? self.id,
            name: name ?? self.name,
            destination: destination ?? self.destination,
            states: states ?? self.states,
            departureDateTime: departureDateTime ?? self.departureDateTime,
            terminal: terminal ?? self.terminal,
            checkinRows: checkinRows ?? self.checkinRows,
            gate: gate ?? self.gate,
            checkinClosingTime: checkinClosingTime ?? self.checkinClosingTime,
            gateOpeningTime: gateOpeningTime ?? self.gateOpeningTime,
            boardingTime: boardingTime ?? self.boardingTime,
            actualDeparturetime: actualDeparturetime ?? self.actualDeparturetime,
            lastUpdated: lastUpdated ?? self.lastUpdated,
            isBookmarked: isBookmarked ?? self.isBookmarked
        )
    }
}
