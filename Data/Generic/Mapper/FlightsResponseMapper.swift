//
//  FlightsResponseMapper.swift
//  MyTerminal
//
//  Created by Mitchell Tol on 03/03/2025.
//

import Foundation

final class FlightsResponseMapper {
    
    let formatter: ISO8601DateFormatter
    
    init() {
        formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    }
    
    func mapListResponseToDomain(response: FlightListResponse) -> [Flight] {
        return response.flights?.compactMap(self.mapResponseToDomain) ?? []
    }
    
    private func mapResponseToDomain(response: FlightDetailResponse) -> Flight? {
        let departureDate: Date? = if let departure = response.departureDateTime {
            mapStringToDate(value: departure)
        } else {
            nil
        }
        
        guard let id = response.id,
              let name = response.flightName,
              let destination = response.route?.destinations?.last,
              let departureDateTime = departureDate,
              let lastUpdated = response.lastUpdated else {
            return nil
        }
        
        let checkinRows: [String]? = if let rows = response.checkinRows { mapCheckinAllocationsToPositions(response: rows) } else { nil }
        let checkinClosingTime: Date? = if let endTime = response.checkinRows?.allocations?.first?.endTime {
            mapStringToDate(value: endTime)
        } else {
            nil
        }
        let gateOpeningTime: Date? = if let gateOpeningTime = response.gateOpeningTime {
            mapStringToDate(value: gateOpeningTime)
        } else {
            nil
        }
        let boardingTime: Date? = if let boardingTime = response.boardingTime {
            mapStringToDate(value: boardingTime)
        } else {
            nil
        }
        let actualDepartureTime: Date? = if let actualDepartureTime = response.actualDepartureTime {
            mapStringToDate(value: actualDepartureTime)
        } else {
            nil
        }
        
        return Flight(
            id: id,
            name: name,
            destination: destination,
            states: response.status?.flightStates,
            departureDateTime: departureDateTime,
            terminal: response.terminal,
            checkinRows: checkinRows,
            gate: response.gate,
            checkinClosingTime: checkinClosingTime,
            gateOpeningTime: gateOpeningTime,
            boardingTime: boardingTime,
            actualDeparturetime: actualDepartureTime,
            lastUpdated: mapStringToDate(value: lastUpdated),
            isBookmarked: false
        )
    }
    
    private func mapStringToDate(value: String) -> Date {
        return formatter.date(from: value) ?? Date.now
    }
    
    private func mapCheckinAllocationsToPositions(response: CheckinAllocationsResponse) -> [String]? {
        return response.allocations?.compactMap { $0.rows }.compactMap { $0.rows }.flatMap { $0 }.compactMap { $0.position }
    }
}
