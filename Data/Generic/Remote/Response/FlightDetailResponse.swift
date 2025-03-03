//
//  FlightDetailResponse.swift
//  MyTerminal
//
//  Created by Mitchell Tol on 03/03/2025.
//

import Foundation

struct FlightDetailResponse: Codable {
    let id: String?
    let flightName: String?
    let route: RouteResponse?
    let status: FlightStateResponse?
    let departureDateTime: String?
    let terminal: Int?
    let checkinRows: CheckinAllocationsResponse?
    let gate: String?
    let gateOpeningTime: String?
    let boardingTime: String?
    let actualDepartureTime: String?
    let lastUpdated: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case flightName = "flightName"
        case route = "route"
        case status = "publicFlightState"
        case departureDateTime = "scheduleDateTime"
        case terminal = "terminal"
        case checkinRows = "checkinAllocations"
        case gate = "gate"
        case gateOpeningTime = "expectedTimeGateOpen"
        case boardingTime = "expectedTimeBoarding"
        case actualDepartureTime = "actualOffBlockTime"
        case lastUpdated = "lastUpdatedAt"
    }
}
