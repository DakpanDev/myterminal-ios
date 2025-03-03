//
//  UnBookmarkFlight.swift
//  MyTerminal
//
//  Created by Mitchell Tol on 25/02/2025.
//

import Foundation

final class UnBookmarkFlight {
    
    private let repository: FlightsRepository
    
    init() {
        self.repository = FlightsRepositoryImpl.shared
    }
    
    func execute(id: String) throws {
        try repository.unBookmarkFlight(id)
    }
}
