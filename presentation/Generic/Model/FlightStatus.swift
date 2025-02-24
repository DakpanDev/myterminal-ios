//
//  FlightStatus.swift
//  MyTerminal
//
//  Created by Mitchell Tol on 24/02/2025.
//

import Foundation

enum FlightStatus: String {
    case scheduled = "Flight Scheduled"
    case delayed = "Delayed"
    case waitinlounge = "Wait in Lounge"
    case gateopen = "Gate Open"
    case boarding = "Boarding"
    case gateclosing = "Gate Closing"
    case gateclosed = "Gate Closed"
    case departed = "Departed"
    case cancelled = "Cancelled"
    case gatechange = "Gate Change"
    case tomorrow = "Tomorrow"
    case unknown = "Unknown"
}
