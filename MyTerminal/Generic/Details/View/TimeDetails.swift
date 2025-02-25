//
//  TimeDetails.swift
//  MyTerminal
//
//  Created by Mitchell Tol on 25/02/2025.
//

import SwiftUI

struct TimeDetails: View {
    var checkInClose: Date?
    var gateOpening: Date?
    var boardingTime: Date?
    var actualDeparture: Date?
    
    var body: some View {
        VStack(spacing: Spacing.x1) {
            TimeRow(
                title: String(localized: "details_checkin_close"),
                time: checkInClose
            )
            TimeRow(
                title: String(localized: "details_gate_open"),
                time: gateOpening
            )
            TimeRow(
                title: String(localized: "details_boarding_time"),
                time: boardingTime
            )
            TimeRow(
                title: String(localized: "details_actual_departure"),
                time: actualDeparture
            )
        }
    }
}

private struct TimeRow: View {
    var title: String
    var time: Date?
    
    var body: some View {
        let unknownText = String(localized: "generic_unknown")
        
        HStack {
            Text(title)
            Spacer()
            Text(time.map { $0.toTimeString() } ?? unknownText)
        }
    }
}

#Preview {
    TimeDetails(
        checkInClose: .now,
        gateOpening: .now,
        boardingTime: .now,
        actualDeparture: .now
    )
}
