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
    private let mapper: FlightsUIMapper
    
    private var _uiState: TypedUIState<FlightListUIModel>
    var uiState: TypedUIState<FlightListUIModel> {
        get { return _uiState }
    }
    
    init() {
        _uiState = .loading
        observeFlights = ObserveFlights()
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
    
    func onSearch(query: String) {
        switch _uiState {
        case .normal(let data):
            let updatedWithQuery = data.flights.map { flight in
                let newFlight = flight.copy(isQueried: compliesWithQuery(query: query, flight: flight))
                return newFlight
            }
            let newUiModel = FlightListUIModel(flights: updatedWithQuery, selectedDate: data.selectedDate)
            _uiState = .normal(data: newUiModel)
        default: break
        }
    }

    func onRetry() {
        let date = _uiState.normalDataOrNil()?.selectedDate
        if (date == nil) { return }
        _uiState = .loading
        observeFlightsByDay(day: date!)
    }

    func onLoadMore() {
        // TODO: implement
    }

    private func compliesWithQuery(query: String, flight: FlightUIModel) -> Bool {
        let upperQuery = query.uppercased()
        let name = flight.name.uppercased()
        let destination = flight.destination.uppercased()
        return upperQuery.isEmpty || name.contains(upperQuery) || destination.contains(upperQuery)
    }
}
