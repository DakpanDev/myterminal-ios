//
//  FlightsDatastoreImpl.swift
//  MyTerminal
//
//  Created by Mitchell Tol on 26/02/2025.
//

import Foundation
import CoreData

final class FlightsDatastoreImpl: FlightsDatastore {
    static let shared = FlightsDatastoreImpl()

    private let database = MyTerminalDB.shared
    private let mapper = FlightsEntityMapper()

    private var cachedPages = Dictionary<String, Int?>()
    
    private var flightChangesContinuation: AsyncStream<FlightsCache>.Continuation?
    private var cachedFlights: FlightsCache = Dictionary() {
        didSet { flightChangesContinuation?.yield(cachedFlights) }
    }
    private var observedFlights: AsyncStream<FlightsCache> {
        AsyncStream { continuation in
            flightChangesContinuation = continuation
            continuation.yield(cachedFlights)
        }
    }
    
    private var bookmarkChangesContinuation: AsyncStream<[Flight]>.Continuation?
    private var cachedBookmarks: [Flight] = [] {
        didSet { bookmarkChangesContinuation?.yield(cachedBookmarks) }
    }
    private var bookmarkedFlights: AsyncStream<[Flight]> {
        AsyncStream { continuation in
            bookmarkChangesContinuation = continuation
            continuation.yield(cachedBookmarks)
        }
    }

    init() {
        do {
            let request = NSFetchRequest<FlightEntity>(entityName: "FlightEntity")
            let bookmarks = try database.fetch(request)
                .map(mapper.mapEntityToFlight)
                .compactMap { $0 }
            cachedBookmarks = bookmarks
        } catch {
            print("Could not retrieve bookmarks")
        }
    }
    
    func updateFlights(date: Date, flights: [Flight]) {
        cachedFlights[toCacheKey(date)] = flights
    }
    
    func observeFlights() -> AsyncStream<FlightsCache> {
        return observedFlights
    }
    
    func getAllCachedFlights() -> [Flight]? {
        return allCachedFlights()
    }
    
    func getCachedFlightsByDate(date: Date) -> [Flight]? {
        return cachedFlights[toCacheKey(date)]
    }
    
    func getFlightDetails(id: String) -> Flight? {
        return allCachedFlights().first { $0.id == id }
    }
    
    func getBookmarkedDetails(id: String) -> Flight? {
        return cachedBookmarks.first{ $0.id == id }
    }
    
    func observeBookmarks() -> AsyncStream<[Flight]> {
        return bookmarkedFlights
    }
    
    func getAllBookmarked() throws -> [Flight] {
        let request = NSFetchRequest<FlightEntity>(entityName: "FlightEntity")
        let bookmarks = try database.fetch(request)
            .map(mapper.mapEntityToFlight)
            .compactMap { $0 }
        return bookmarks
    }
    
    func bookmarkFlight(flight: Flight) {
        let entity = mapper.mapFlightToEntity(
            context: database.getContext(),
            flight: flight
        )
        do {
            try database.insertAndSave(entity)
            cachedBookmarks = try getAllBookmarked()
        } catch {
            print("Could not bookmark flight")
        }
    }
    
    func unBookmarkFlight(flight: Flight) {
        let request = NSFetchRequest<FlightEntity>(entityName: "FlightEntity")
        request.predicate = NSPredicate(format: "id LIKE %@", flight.id)
        do {
            for entity in try database.fetch(request) {
                database.delete(entity)
            }
            try database.save()
            var newCache = try getAllBookmarked()
            newCache.append(flight.copy(isBookmarked: false))
            cachedBookmarks = newCache
        } catch {
            print("Could not unbookmark flight")
        }
    }
    
    func getHighestPage(date: Date) -> Int? {
        return cachedPages[toCacheKey(date)] ?? nil
    }
    
    func incrementPage(date: Date) {
        let nextValue = if let cachedValue = getHighestPage(date: date) {
            cachedValue + 1
        } else {
            0
        }
        
        cachedPages[toCacheKey(date)] = nextValue
    }
    
    private func allCachedFlights() -> [Flight] {
        return cachedFlights.values.flatMap { $0 }
    }
    
    private func toCacheKey(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}
