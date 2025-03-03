//
//  FetchMoreFlights.swift
//  MyTerminal
//
//  Created by Mitchell Tol on 03/03/2025.
//

import Foundation

final class FetchMoreFlights {
    private let repository: FlightsRepository
    
    init() {
        repository = FlightsRepositoryImpl.shared
    }
    
    func execute(date: Date) throws {
        Task {
            try await repository.fetchFlights(date: date)
        }
    }
}
