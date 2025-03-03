//
//  ObserveBookmark.swift
//  MyTerminal
//
//  Created by Mitchell Tol on 03/03/2025.
//

import Foundation

final class ObserveBookmark {
    private let repository: FlightsRepository
    
    init() {
        repository = FlightsRepositoryImpl.shared
    }
    
    func execute(flightId: String) -> AsyncStream<Flight> {
        return repository.observeBookmark(id: flightId)
    }
}
