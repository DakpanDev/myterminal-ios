//
//  FlightUIModel.swift
//  Presentation
//
//  Created by Mitchell Tol on 24/02/2025.
//

import Foundation

struct FlightUIModel: Identifiable, Hashable {
    let id: String
    let name: String
    let destination: String
    let date: Date
    let isQueried: Bool
    
    init(id: String, name: String, destination: String, date: Date, isQueried: Bool = true) {
        self.id = id
        self.name = name
        self.destination = destination
        self.date = date
        self.isQueried = isQueried
    }
    
    func copy(id: String? = nil, name: String? = nil, destination: String? = nil, date: Date? = nil, isQueried: Bool? = nil) -> FlightUIModel {
        return FlightUIModel(
            id: id ?? self.id,
            name: name ?? self.name,
            destination: destination ?? self.destination,
            date: date ?? self.date,
            isQueried: isQueried ?? self.isQueried
        )
    }
}
