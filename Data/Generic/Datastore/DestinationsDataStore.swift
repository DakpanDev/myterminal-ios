//
//  DestinationsDataStore.swift
//  MyTerminal
//
//  Created by Mitchell Tol on 10/03/2025.
//

import Foundation

protocol DestinationsDataStore {
    
    func getDestinationValue(iata: String) -> String?
    
    func storeDestination(iata: String, value: String)
}
