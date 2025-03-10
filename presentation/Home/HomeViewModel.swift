//
//  HomeViewModel.swift
//  Presentation
//
//  Created by Mitchell Tol on 19/02/2025.
//

import Foundation

@Observable
final class HomeViewModel {
    private let observeFlights: ObserveFlights
    private let fetchMoreFlights: FetchMoreFlights
    private let mapper: FlightsUIMapper
    
    private var _uiState: TypedUIState<FlightListUIModel>
    var uiState: TypedUIState<FlightListUIModel> {
        get { return _uiState }
    }
    
    init() {
        _uiState = .loading
        observeFlights = ObserveFlights()
        fetchMoreFlights = FetchMoreFlights()
        mapper = FlightsUIMapper()
        observeFlightsByDay(day: .now)
    }
    
    private func observeFlightsByDay(day: Date) {
        Task {
            do {
                for await flights in try observeFlights.execute(date: day) {
                    let uiModel = mapper.mapFlightListToUiModel(flights)
                    _uiState = .normal(data: uiModel)
                }
            } catch {
                onFetchFlightsError()
            }
        }
    }
    
    private func onFetchFlightsError() {
        print("An error occurred while retrieving flights")
        _uiState = .error
    }
    
    func onDateChange(date: Date) {
        _uiState = .loading
        observeFlightsByDay(day: date)
    }
    
    func onQueryChange(query: String) {
        if let data = _uiState.normalDataOrNil() {
            let updatedWithQuery = data.flights.map { flight in
                let newFlight = flight.copy(isQueried: compliesWithQuery(query: query, flight: flight))
                return newFlight
            }
            let newUiModel = data.copy(flights: updatedWithQuery, searchQuery: query)
            _uiState = .normal(data: newUiModel)
        }
    }

    func onRetry() {
        let date = _uiState.normalDataOrNil()?.selectedDate
        if (date == nil) { return }
        _uiState = .loading
        observeFlightsByDay(day: date!)
    }

    func onLoadMore() {
        if let data = _uiState.normalDataOrNil() {
            Task {
                do {
                    let date = data.flights.first?.date ?? Date.now
                    try fetchMoreFlights.execute(date: date)
                } catch {
                    onFetchMoreFlightsError()
                }
            }
        }
    }
    
    func onFetchMoreFlightsError() {
        print("An error occurred while fetching more flights")
    }

    private func compliesWithQuery(query: String, flight: FlightUIModel) -> Bool {
        let upperQuery = query.uppercased()
        let name = flight.name.uppercased()
        let destination = flight.destination.uppercased()
        return upperQuery.isEmpty || name.contains(upperQuery) || destination.contains(upperQuery)
    }
}
