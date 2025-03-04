//
//  FlightsEntityMapper.swift
//  MyTerminal
//
//  Created by Mitchell Tol on 26/02/2025.
//

import Foundation
import CoreData

final class FlightsEntityMapper {
    
    func mapEntityToFlight(entity: FlightEntity) -> Flight? {
        guard let id = entity.id,
              let name = entity.name,
              let destination = entity.destination,
              let departureDateTime = entity.departureDateTime,
              let lastUpdated = entity.lastUpdated else {
            return nil
        }
        
        let states: [String]? = entity.states?.split(separator: ",").map { String($0) }
        let terminal: Int? = entity.terminal.flatMap { Int($0) }
        let checkinRows: [String]? = entity.checkinRows?.split(separator: ",").map { String($0) }
        
        return Flight(
            id: id,
            name: name,
            destination: destination,
            states: states,
            departureDateTime: departureDateTime,
            terminal: terminal,
            checkinRows: checkinRows,
            gate: entity.gate,
            checkinClosingTime: entity.checkinClosingTime,
            gateOpeningTime: entity.gateOpeningTime,
            boardingTime: entity.boardingTime,
            actualDeparturetime: entity.actualDepartureTime,
            lastUpdated: lastUpdated,
            isBookmarked: true
        )
    }
    
    func mapFlightToEntity(context: NSManagedObjectContext, flight: Flight) -> FlightEntity {
        let entity = FlightEntity(context: context)
        entity.id = flight.id
        entity.name = flight.name
        entity.destination = flight.destination
        entity.states = flight.states?.joined(separator: ",")
        entity.departureDateTime = flight.departureDateTime
        if let terminal = flight.terminal { entity.terminal = "\(terminal)" }
        entity.checkinRows = flight.checkinRows?.joined(separator: ",")
        entity.gate = flight.gate
        entity.checkinClosingTime = flight.checkinClosingTime
        entity.gateOpeningTime = flight.gateOpeningTime
        entity.boardingTime = flight.boardingTime
        entity.actualDepartureTime = flight.actualDeparturetime
        entity.lastUpdated = flight.lastUpdated
        return entity
    }
}
