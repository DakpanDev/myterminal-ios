//
//  FlightListUIModel.swift
//  Presentation
//
//  Created by Mitchell Tol on 24/02/2025.
//

import Foundation

struct FlightListUIModel {
    let flights: [FlightUIModel]
    let selectedDate: Date
    let searchQuery: String
    
    init(
        flights: [FlightUIModel],
        selectedDate: Date = Date.now,
        searchQuery: String = ""
    ) {
        self.flights = flights
        self.selectedDate = selectedDate
        self.searchQuery = searchQuery
    }
    
    func copy(
        flights: [FlightUIModel]? = nil,
        selectedDate: Date? = nil,
        searchQuery: String? = nil
    ) -> FlightListUIModel {
        return FlightListUIModel(
            flights: flights ?? self.flights,
            selectedDate: selectedDate ?? self.selectedDate,
            searchQuery: searchQuery ?? self.searchQuery
        )
    }
}
