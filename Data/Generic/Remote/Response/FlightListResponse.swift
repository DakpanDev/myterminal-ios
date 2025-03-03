//
//  FlightListResponse.swift
//  MyTerminal
//
//  Created by Mitchell Tol on 26/02/2025.
//

import Foundation

struct FlightListResponse: Decodable {
    let flights: [FlightDetailResponse]?
}
