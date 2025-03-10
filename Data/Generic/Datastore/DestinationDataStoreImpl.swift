//
//  DestinationDataStoreImpl.swift
//  MyTerminal
//
//  Created by Mitchell Tol on 10/03/2025.
//

import Foundation
import CoreData

final class DestinationDataStoreImpl: DestinationsDataStore {
    static let shared = DestinationDataStoreImpl()
    
    private let database = MyTerminalDB.shared
    
    func getDestinationValue(iata: String) -> String? {
        do {
            let request = NSFetchRequest<DestinationEntity>(entityName: "DestinationEntity")
            request.predicate = NSPredicate(format: "iata LIKE %@", iata)
            return try database.fetch(request).first?.value
        } catch {
            return nil
        }
    }
    
    func storeDestination(iata: String, value: String) {
        let entity = DestinationEntity(context: database.getContext())
        entity.iata = iata
        entity.value = value
        do {
            try database.insertAndSave(entity)
        } catch {
            print("Could not store destination: \(entity)")
        }
    }
}
