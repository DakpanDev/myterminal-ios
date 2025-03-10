//
//  MyTerminalDB.swift
//  MyTerminal
//
//  Created by Mitchell Tol on 10/03/2025.
//

import Foundation
import CoreData

final class MyTerminalDB {
    static let shared = MyTerminalDB()
    
    private lazy var database: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Database")
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Failed to load persistent stores: \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    func getContext() -> NSManagedObjectContext {
        return database.viewContext
    }
    
    func fetch<T>(_ request: NSFetchRequest<T>) throws -> [T] {
        return try database.viewContext.fetch(request)
    }
    
    func insert(_ entity: NSManagedObject) {
        database.viewContext.insert(entity)
    }
    
    func insertAndSave(_ entity: NSManagedObject) throws {
        database.viewContext.insert(entity)
        try database.viewContext.save()
    }
    
    func delete(_ entity: NSManagedObject) {
        database.viewContext.delete(entity)
    }
    
    func deleteAndSave(_ entity: NSManagedObject) throws {
        database.viewContext.delete(entity)
        try database.viewContext.save()
    }
    
    func save() throws {
        try database.viewContext.save()
    }
}
