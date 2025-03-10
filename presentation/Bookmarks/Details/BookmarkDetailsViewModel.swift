//
//  BookmarkDetailsViewModel.swift
//  MyTerminal
//
//  Created by Mitchell Tol on 05/03/2025.
//

import Foundation

@Observable
final class BookmarkDetailsViewModel {
    private let args: BookmarkDetailsViewModelArgs
    private let observeBookmark: ObserveBookmark
    private let bookmarkFlight: BookmarkFlight
    private let unBookmarkFlight: UnBookmarkFlight
    private let mapper: DetailsUIMapper
    
    private var _uiState: TypedUIState<DetailsUIModel>
    var uiState: TypedUIState<DetailsUIModel> {
        get { return _uiState }
    }
    
    init(args: BookmarkDetailsViewModelArgs) {
        _uiState = .loading
        self.args = args
        observeBookmark = ObserveBookmark()
        bookmarkFlight = BookmarkFlight()
        unBookmarkFlight = UnBookmarkFlight()
        mapper = DetailsUIMapper()
        retrieveDetails()
    }
    
    private func retrieveDetails() {
        Task {
            for await bookmark in observeBookmark.execute(flightId: args.flightId) {
                let mapped = mapper.mapFlightToDetails(flight: bookmark)
                _uiState = .normal(data: mapped)
            }
        }
    }
    
    private func onRetrieveBookmarkError() {
        print("An error occurred while retrieving bookmark")
        _uiState = .error
    }
    
    func onBookmark() {
        Task {
            do {
                if let data = _uiState.normalDataOrNil() {
                    if (data.isBookmarked) {
                        try unBookmarkFlight.execute(id: data.id)
                    } else {
                        try bookmarkFlight.execute(id: data.id)
                    }
                }
            } catch {
                onBookmarkError()
            }
        }
    }
    
    private func onBookmarkError() {
        print("An error occurred while (un)bookmarking flight with ID \(args.flightId)")
    }
    
    func onRetry() {
        _uiState = .loading
        retrieveDetails()
    }
}
