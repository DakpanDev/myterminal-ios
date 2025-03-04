//
//  BookmarksUIModel.swift
//  MyTerminal
//
//  Created by Mitchell Tol on 03/03/2025.
//

import Foundation

struct BookmarksUIModel {
    let flights: [FlightUIModel]
    
    init(flights: [FlightUIModel] = []) {
        self.flights = flights
    }
}
