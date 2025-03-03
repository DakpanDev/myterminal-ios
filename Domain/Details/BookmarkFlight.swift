//
//  BookmarkFlight.swift
//  Domain
//
//  Created by Mitchell Tol on 25/02/2025.
//

import Foundation

final class BookmarkFlight {
    
    private let repository: FlightsRepository
    
    init() {
        self.repository = FlightsRepositoryImpl.shared
    }
    
    func execute(id: String) throws {
        try repository.bookmarkFlight(id)
    }
}
