//
//  BookmarkFlight.swift
//  Domain
//
//  Created by Mitchell Tol on 25/02/2025.
//

import Foundation

final class BookmarkFlight {
    
    private let repository: FlightsRepository
    
    init(repository: FlightsRepository) {
        self.repository = repository
    }
    
    func execute(id: String) throws {
        try repository.bookmarkFlight(id)
    }
}
