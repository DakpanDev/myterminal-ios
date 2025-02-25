//
//  FlightStatusExtension.swift
//  MyTerminal
//
//  Created by Mitchell Tol on 25/02/2025.
//

import Foundation
import SwiftUI

extension FlightStatus {
    
    func getColor() -> Color {
        return switch self {
        case .scheduled: .blue
        case .delayed: .yellow
        case .waitinlounge: .blue
        case .gateopen: .green
        case .boarding: .green
        case .gateclosing: .orange
        case .gateclosed: .red
        case .departed: .orange
        case .cancelled: .red
        case .gatechange: .yellow
        case .tomorrow: .blue
        case .unknown: .yellow
        }
    }
}
