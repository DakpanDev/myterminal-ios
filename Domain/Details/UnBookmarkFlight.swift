//
//  UnBookmarkFlight.swift
//  MyTerminal
//
//  Created by Mitchell Tol on 25/02/2025.
//

import Foundation

final class UnBookmarkFlight {
    
    private let repository: FlightsRepository
    
    init(repository: FlightsRepository) {
        self.repository = repository
    }
    
    func execute(id: String) throws {
        try repository.unBookmarkFlight(id)
    }
}
