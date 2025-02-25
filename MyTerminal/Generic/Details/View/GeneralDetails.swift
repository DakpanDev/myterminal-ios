//
//  GeneralDetails.swift
//  MyTerminal
//
//  Created by Mitchell Tol on 25/02/2025.
//

import SwiftUI

struct GeneralDetails: View {
    var flightName: String
    var destination: String
    var states: [FlightStatus]
    var departureDate: Date
    
    var body: some View {
        let stateStrings = states.map { state in
            AttributedString(
                state.rawValue,
                attributes: AttributeContainer().foregroundColor(state.getColor())
            )
        }
        let concatenated = concatenateAttributedStrings(attributedStrings: stateStrings)
        let dateString = departureDate.toDateString()
        let timeString = departureDate.toTimeString()
    
        VStack(alignment: .leading, spacing: Spacing.x1) {
            Text("details_flight_name:\(flightName)")
                .font(.title)
            Text("details_destination:\(destination)")
                .font(.title2)
            Text("details_status:\(concatenated)")
                .font(.title2)
            Text("details_scheduled_departure:\(dateString):\(timeString)")
                .font(.title2)
        }
    }
}

#Preview {
    GeneralDetails(
        flightName: "HV6935",
        destination: "TIA",
        states: [.departed],
        departureDate: Date.now
    )
}

func concatenateAttributedStrings(attributedStrings: [AttributedString]) -> AttributedString {
    guard !attributedStrings.isEmpty else { return AttributedString() }

    var result = attributedStrings[0]

    for attributedString in attributedStrings.dropFirst() {
        result += AttributedString(", ")
        result += attributedString
    }

    return result
}
