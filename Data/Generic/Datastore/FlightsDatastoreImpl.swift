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

    private lazy var database: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Database")
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Failed to load persistent stores: \(error.localizedDescription)")
            }
        }
        return container
    }()
    private let mapper = FlightsEntityMapper()

    private var cachedPages = Dictionary<Date, Int?>()
    
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
            let bookmarks = try database.viewContext.fetch(request)
                .map(mapper.mapEntityToFlight)
                .compactMap { $0 }
            cachedBookmarks = bookmarks
        } catch {
            print("Could not retrieve bookmarks")
        }
    }
    
    func updateFlights(date: Date, flights: [Flight]) {
        cachedFlights[date] = flights
    }
    
    func observeFlights() -> AsyncStream<FlightsCache> {
        return observedFlights
    }
    
    func getAllCachedFlights() -> [Flight]? {
        return allCachedFlights()
    }
    
    func getCachedFlightsByDate(date: Date) -> [Flight]? {
        return cachedFlights[date]
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
        let bookmarks = try database.viewContext.fetch(request)
            .map(mapper.mapEntityToFlight)
            .compactMap { $0 }
        return bookmarks
    }
    
    func bookmarkFlight(flight: Flight) {
        let entity = mapper.mapFlightToEntity(
            context: database.viewContext,
            flight: flight
        )
        do {
            database.viewContext.insert(entity)
            try database.viewContext.save()
            cachedBookmarks = try getAllBookmarked()
        } catch {
            print("Could not bookmark flight")
        }
    }
    
    func unBookmarkFlight(flight: Flight) {
        let entity = mapper.mapFlightToEntity(
            context: database.viewContext,
            flight: flight
        )
        do {
            database.viewContext.delete(entity)
            try database.viewContext.save()
            cachedBookmarks = try getAllBookmarked()
        } catch {
            print("Could not unbookmark flight")
        }
    }
    
    func getHighestPage(date: Date) -> Int? {
        return cachedPages[date] ?? nil
    }
    
    func incrementPage(date: Date) {
        let nextValue = if let cachedValue = getHighestPage(date: date) {
            cachedValue + 1
        } else {
            0
        }
        
        cachedPages[date] = nextValue
    }
    
    private func allCachedFlights() -> [Flight] {
        return cachedFlights.values.flatMap { $0 }
    }
}
