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
            do {
                if (data.isBookmarked) {
                    try unBookmarkFlight.execute(id: data.id)
                } else {
                    try bookmarkFlight.execute(id: data.id)
                }
            } catch {
                onBookmarkError(isBookmarked: data.isBookmarked)
            }
        }
    }
    
    private func onBookmarkError(isBookmarked: Bool) {
        print("An error occurred trying to \(isBookmarked ? "un" : "")bookmark flight")
    }
    
    func onRetry() {
        _uiState = .loading
        retrieveDetails()
    }
}
