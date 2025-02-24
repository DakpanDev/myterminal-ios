//
//  HomeViewModel.swift
//  Presentation
//
//  Created by Mitchell Tol on 19/02/2025.
//

import Foundation

@Observable
final class HomeViewModel {
    
    private var _uiState: TypedUIState<FlightListUIModel>
    var uiState: TypedUIState<FlightListUIModel> {
        get {
            return _uiState
        }
    }
    
    init() {
        self._uiState = .loading
    }
    
    func observeFlightsByDay(day: Date) {
        // TODO: implement
        Task {
            sleep(3)
            self._uiState = .normal(data: FlightListUIModel(flights: []))
        }
    }
}
