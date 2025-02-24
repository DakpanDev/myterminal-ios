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
    let newFlightsLoading: Bool
    
    init(
        flights: [FlightUIModel],
        selectedDate: Date = Date.now,
        newFlightsLoading: Bool = false
    ) {
        self.flights = flights
        self.selectedDate = selectedDate
        self.newFlightsLoading = newFlightsLoading
    }
}
