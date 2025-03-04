//
//  FlightsRepositoryImpl.swift
//  Data
//
//  Created by Mitchell Tol on 25/02/2025.
//

import Foundation

final class FlightsRepositoryImpl: FlightsRepository {
    static let shared = FlightsRepositoryImpl()
    
    private let flightsDatastore: FlightsDatastore
    private let api: SchipholService
    private let mapper: FlightsResponseMapper
    
    init() {
        self.flightsDatastore = FlightsDatastoreImpl.shared
        self.api = SchipholService()
        self.mapper = FlightsResponseMapper()
    }
    
    func fetchFlights(date: Date) async throws {
        Task {
            let nextPage = flightsDatastore.getHighestPage(date: date) ?? 0
            let response = try await api.retrieveFlights(page: nextPage, date: date)
            
            let bookmarked = try getAllBookmarked().map { $0.id }
            let oldFlights = flightsDatastore.getCachedFlightsByDate(date: date) ?? []
            let newFlights = mapper.mapListResponseToDomain(response: response).map {
                $0.copy(
                    // TODO: destination
                    isBookmarked: bookmarked.contains($0.id)
                )
            }
            let updatedFlights = oldFlights + newFlights
            
            flightsDatastore.updateFlights(date: date, flights: updatedFlights)
            flightsDatastore.incrementPage(date: date)
        }
    }
    
    func observeFlights(date: Date) throws -> AsyncStream<[Flight]> {
        return AsyncStream { continuation in
            Task {
                for await cache in flightsDatastore.observeFlights() {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    let key = formatter.string(from: date)
                    
                    let flights = cache[key] ?? []
                    if !flights.isEmpty {
                        continuation.yield(flights)
                    } else {
                        try await fetchFlights(date: date)
                    }
                }
            }
        }
    }
    
    func observeFlightDetails(_ id: String) throws -> AsyncStream<Flight> {
        return AsyncStream { continuation in
            Task {
                for await cache in flightsDatastore.observeFlights() {
                    if let flight = cache.values.flatMap({ $0 }).first(where: { $0.id == id }) {
                        continuation.yield(flight)
                    }
                }
            }
        }
    }
    
    func observeAllBookmarks() -> AsyncStream<[Flight]> {
        return flightsDatastore.observeBookmarks()
    }
    
    func observeBookmark(id: String) -> AsyncStream<Flight> {
        return AsyncStream { continuation in
            Task {
                for await flights in flightsDatastore.observeBookmarks() {
                    if let flight = flights.first(where: { $0.id == id }) {
                        continuation.yield(flight)
                    }
                }
            }
        }
    }
    
    func bookmarkFlight(_ id: String) throws {
        if let flight = flightsDatastore.getFlightDetails(id: id) {
            setBookmarkState(flight: flight, isBookmarked: true)
        } else {
            throw IllegalStateError(message: "Flight with id \(id) could not be found")
        }
    }
    
    func unBookmarkFlight(_ id: String) throws {
        if let flight = flightsDatastore.getBookmarkedDetails(id: id) {
            setBookmarkState(flight: flight, isBookmarked: false)
        } else {
            throw IllegalStateError(message: "Bookmarked flight with id \(id) could not be found")
        }
    }
    
    private func setBookmarkState(flight: Flight, isBookmarked: Bool) {
        let date = flight.departureDateTime
        if (isBookmarked) {
            flightsDatastore.bookmarkFlight(flight: flight)
        } else {
            flightsDatastore.unBookmarkFlight(flight: flight)
        }
        if let cachedFlights = flightsDatastore.getCachedFlightsByDate(date: date) {
            let updated = cachedFlights.map { $0.id == flight.id ? $0.copy(isBookmarked: isBookmarked) : $0 }
            flightsDatastore.updateFlights(date: date, flights: updated)
        }
    }
    
    private func getAllBookmarked() throws -> [Flight] {
        return try flightsDatastore.getAllBookmarked()
    }
}
