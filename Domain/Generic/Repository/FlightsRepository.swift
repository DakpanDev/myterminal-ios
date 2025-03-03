//
//  FlightsRepository.swift
//  Domain
//
//  Created by Mitchell Tol on 25/02/2025.
//

import Foundation
import Combine

protocol FlightsRepository {
    
    func fetchFlights(date: Date) async throws
    func observeFlights(date: Date) throws -> AsyncStream<[Flight]>
    func observeFlightDetails(_ id: String) throws -> AsyncStream<Flight>
    
    func observeAllBookmarks() -> AsyncStream<[Flight]>
    func observeBookmark(id: String) -> AsyncStream<Flight>
    func bookmarkFlight(_ id: String) throws
    func unBookmarkFlight(_ id: String) throws
}
