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
    
    init(
        flights: [FlightUIModel],
        selectedDate: Date = Date.now
    ) {
        self.flights = flights
        self.selectedDate = selectedDate
    }
}
