//
//  FlightDetailsView.swift
//  MyTerminal
//
//  Created by Mitchell Tol on 24/02/2025.
//

import SwiftUI

struct FlightDetailsView: View {
    var flightId: String
    
    var body: some View {
        Text("Flight ID: \(flightId)")
    }
}

#Preview {
    let flightId = "flight_id"
    FlightDetailsView(flightId: flightId)
}
