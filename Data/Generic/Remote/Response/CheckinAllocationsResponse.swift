//
//  CheckinAllocationsResponse.swift
//  MyTerminal
//
//  Created by Mitchell Tol on 03/03/2025.
//

import Foundation

struct CheckinAllocationsResponse: Codable {
    let allocations: [CheckinAllocationResponse]?
    
    enum CodingKeys: String, CodingKey {
        case allocations = "checkinAllocations"
    }
}

struct CheckinAllocationResponse: Codable {
    let endTime: String?
    let rows: RowsResponse?
}

struct RowsResponse: Codable {
    let rows: [RowResponse]?
}

struct RowResponse: Codable {
    let position: String?
}
