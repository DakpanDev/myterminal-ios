//
//  ObserveFlights.swift
//  MyTerminal
//
//  Created by Mitchell Tol on 03/03/2025.
//

import Foundation

final class ObserveFlights {
    private let repository: FlightsRepository
    
    init() {
        repository = FlightsRepositoryImpl.shared
    }
    
    func execute(date: Date = Date.now) throws -> AsyncStream<[Flight]> {
        return try repository.observeFlights(date: date)
    }
}
