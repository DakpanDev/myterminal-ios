//
//  ObserveAllBookmarks.swift
//  MyTerminal
//
//  Created by Mitchell Tol on 03/03/2025.
//

import Foundation

final class ObserveAllBookmarks {
    private let repository: FlightsRepository
    
    init() {
        repository = FlightsRepositoryImpl.shared
    }
    
    func execute() -> AsyncStream<[Flight]> {
        return repository.observeAllBookmarks()
    }
}
