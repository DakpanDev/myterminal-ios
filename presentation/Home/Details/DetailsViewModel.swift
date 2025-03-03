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
    private let observeFlightDetails: ObserveFlightDetails
    private let bookmarkFlight: BookmarkFlight
    private let unBookmarkFlight: UnBookmarkFlight
    private let mapper: DetailsUIMapper
    
    private var _uiState: TypedUIState<DetailsUIModel>
    var uiState: TypedUIState<DetailsUIModel> {
        get { return _uiState }
    }
    
    init(args: DetailsViewModelArgs) {
        self.args = args
        _uiState = .loading
        observeFlightDetails = ObserveFlightDetails()
        bookmarkFlight = BookmarkFlight()
        unBookmarkFlight = UnBookmarkFlight()
        mapper = DetailsUIMapper()
        retrieveDetails()
    }
    
    private func retrieveDetails() {
        Task {
            do {
                for await details in try observeFlightDetails.execute(args.flightId) {
                    let mapped = mapper.mapFlightToDetails(flight: details)
                    _uiState = .normal(data: mapped)
                }
            } catch {
                onRetrieveDetailsError()
            }
        }
    }
    
    private func onRetrieveDetailsError() {
        print("An error occurred while retrieving details")
        _uiState = .error
    }
    
    func onBookmark() {
        if let data = _uiState.normalDataOrNil() {
            if (data.isBookmarked) {
                // TODO: unBookmarkFlight(data.id)
                print("Unbookmark \(data.id)")
            } else {
                // TODO: bookmarkFlight(data.id)
                print("Bookmark \(data.id)")
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
