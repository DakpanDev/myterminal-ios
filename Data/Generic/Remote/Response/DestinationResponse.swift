//
//  DestinationResponse.swift
//  MyTerminal
//
//  Created by Mitchell Tol on 10/03/2025.
//

import Foundation

struct DestinationResponse: Codable {
    let iata: String
    let country: String?
    let city: String?
    let publicName: PublicNameResponse?
}

struct PublicNameResponse: Codable {
    let english: String?
}
