//
//  LocationDetails.swift
//  MyTerminal
//
//  Created by Mitchell Tol on 25/02/2025.
//

import SwiftUI

struct LocationDetails: View {
    var terminal: Int?
    var checkInRows: [String]
    var gate: String?
    
    var body: some View {
        let unknownText = String(localized: "generic_unknown")
        let checkInText = checkInRows.isEmpty ? unknownText : checkInRows.joined(separator: " & ")
        let terminalText = terminal.map { String($0) } ?? unknownText
        let gateText = gate ?? unknownText
        
        VStack(spacing: Spacing.x1) {
            Divider()
            HStack {
                Spacer()
                Text("details_terminal:\(terminalText)")
                    .multilineTextAlignment(.center)
                Spacer()
                Text("details_checkin:\(checkInText)")
                    .multilineTextAlignment(.center)
                Spacer()
                Text("details_gate:\(gateText)")
                    .multilineTextAlignment(.center)
                Spacer()
            }
            .padding(.horizontal, Spacing.x3)
            Divider()
        }
    }
}

#Preview {
    LocationDetails(
        terminal: 5,
        checkInRows: ["4", "5"],
        gate: "4A"
    )
}
