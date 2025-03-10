//
//  BookmarksViewModel.swift
//  MyTerminal
//
//  Created by Mitchell Tol on 03/03/2025.
//

import Foundation

@Observable
final class BookmarksViewModel {
    private let observeAllBookmarks: ObserveAllBookmarks
    private let mapper: FlightsUIMapper
    
    private var _uiModel = BookmarksUIModel()
    var uiModel: BookmarksUIModel {
        get { return _uiModel }
    }
    
    init() {
        observeAllBookmarks = ObserveAllBookmarks()
        mapper = FlightsUIMapper()
        retrieveBookmarks()
    }
    
    private func retrieveBookmarks() {
        Task {
            for await flightList in observeAllBookmarks.execute() {
                let mapped = flightList
                    .filter { $0.isBookmarked }
                    .map(mapper.mapFlightToUiModel)
                _uiModel = BookmarksUIModel(flights: mapped)
            }
        }
    }
    
    func onResume() {
        retrieveBookmarks()
    }
}
