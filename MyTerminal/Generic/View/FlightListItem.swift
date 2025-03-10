//
//  FlightListItem.swift
//  MyTerminal
//
//  Created by Mitchell Tol on 24/02/2025.
//

import SwiftUI

struct FlightListItem: View {
    var uiModel: FlightUIModel
    
    var body: some View {
        if (uiModel.isQueried) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: Spacing.x1) {
                    Text(uiModel.name)
                    Text(uiModel.destination)
                }
                Spacer()
                Text(uiModel.date, format: .dateTime.day().month().year())
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: Spacing.x0_5)
                    .stroke(.primary)
            )
        }
    }
}

#Preview {
    let uiModel = FlightUIModel(id: "1", name: "HV6935", destination: "Tirana", date: Date.now, isQueried: true)
    
    FlightListItem(uiModel: uiModel)
}
