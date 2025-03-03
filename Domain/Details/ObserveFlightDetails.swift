//
//  ObserveFlightDetails.swift
//  MyTerminal
//
//  Created by Mitchell Tol on 03/03/2025.
//

import Foundation

final class ObserveFlightDetails {
    private let repository: FlightsRepository
    
    init() {
        repository = FlightsRepositoryImpl.shared
    }
    
    func execute(_ id: String) throws -> AsyncStream<Flight> {
        return try repository.observeFlightDetails(id)
    }
}
