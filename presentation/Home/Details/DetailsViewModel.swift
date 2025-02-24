//
//  DetailsViewModel.swift
//  MyTerminal
//
//  Created by Mitchell Tol on 24/02/2025.
//

import Foundation

@Observable
final class DetailsViewModel {
    
    private let args: DetailsViewModelArgs
    
    private var _uiState: TypedUIState<DetailsUIModel>
    var uiState: TypedUIState<DetailsUIModel> {
        get { return _uiState }
    }
    
    init(args: DetailsViewModelArgs) {
        self.args = args
        _uiState = .loading
        retrieveDetails()
    }
    
    private func retrieveDetails() {
        Task {
            sleep(1)
            let details = getDummyData(flightId: args.flightId)
            _uiState = .normal(data: details)
        }
    }
    
    func onBookmark() {
        if let data = _uiState.normalDataOrNil() {
            if (data.isBookmarked) {
                // TODO: unBookmarkFlight(data.id)
            } else {
                // TODO: bookmarkFlight(data.id)
            }
        }
    }
    
    func onRetry() {
        _uiState = .loading
        retrieveDetails()
    }
    
    private func getDummyData(flightId: String) -> DetailsUIModel {
        return DetailsUIModel(
            id: flightId,
            name: "HV6935",
            destination: "Tirana",
            states: [.boarding, .scheduled],
            departureDateTime: Date.now,
            terminal: 3,
            checkinRows: ["5", "6"],
            gate: "8B",
            checkinClosingTime: Date.now,
            gateOpeningTime: nil,
            boardingTime: Date.now,
            actualDepartureTime: Date.now,
            lastUpdated: Date.now,
            isBookmarked: false
        )
    }
}
