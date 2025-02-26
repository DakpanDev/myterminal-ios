//
//  FlightsDatastore.swift
//  Data
//
//  Created by Mitchell Tol on 25/02/2025.
//

import Foundation

protocol FlightsDatastore {
    
    func updateFlights(date: Date, flights: [Flight])
    func observeFlights() -> AsyncStream<FlightsCache>
    func getAllCachedFlights() -> [Flight]?
    func getCachedFlightsByDate(date: Date) -> [Flight]?
    
    func getFlightDetails(id: String) -> Flight?
    func getBookmarkedDetails(id: String) -> Flight?
    
    func observeBookmarks() -> AsyncStream<[Flight]>
    func getAllBookmarked() throws -> [Flight]
    
    func bookmarkFlight(flight: Flight)
    func unBookmarkFlight(flight: Flight)
    
    func getHighestPage(date: Date) -> Int?
    func incrementPage(date: Date)
}
