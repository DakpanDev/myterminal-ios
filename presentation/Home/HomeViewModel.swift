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
        get { return _uiState }
    }
    
    init() {
        self._uiState = .loading
    }
    
    func observeFlightsByDay(day: Date) {
        // TODO: implement
        Task {
            sleep(1)
            let flights = getDummyFlights()
            _uiState = .normal(data: FlightListUIModel(flights: flights, selectedDate: day))
        }
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
    
    private func getDummyFlights() -> [FlightUIModel] {
        return [
            FlightUIModel(id: "1", name: "HV6935", destination: "Tirana", date: Date.now, isQueried: true),
            FlightUIModel(id: "2", name: "HV5685", destination: "Lanzarote", date: Date.now, isQueried: true),
            FlightUIModel(id: "3", name: "HV6673", destination: "Tenerife", date: Date.now, isQueried: true),
            FlightUIModel(id: "4", name: "DL7505", destination: "Tenerife", date: Date.now, isQueried: true),
        ]
    }
}
