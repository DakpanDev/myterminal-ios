//
//  HomeView.swift
//  MyTerminal
//
//  Created by Mitchell Tol on 19/02/2025.
//

import SwiftUI

struct HomeView: View {
    @Environment(HomeViewModel.self) private var viewModel

    var body: some View {
        HomeViewContent(
            uiState: viewModel.uiState,
            onDateChange: viewModel.onDateChange,
            onQueryChange: viewModel.onQueryChange,
            onRetry: viewModel.onRetry,
            onLoadMore: viewModel.onLoadMore
        )
    }
}

private struct HomeViewContent: View {
    var uiState: TypedUIState<FlightListUIModel>
    var onDateChange: (Date) -> Void
    var onQueryChange: (String) -> Void
    var onRetry: () -> Void
    var onLoadMore: () -> Void

    @State private var selectedDate = Date()
    
    private var query: Binding<String> {
        Binding(
            get: { uiState.normalDataOrNil()?.searchQuery ?? "" },
            set: { onQueryChange($0) }
        )
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    SearchBar(value: query)
                    .padding(.vertical, Spacing.x2)

                    switch uiState {
                    case .loading:
                        LoadingState()
                    case .error:
                        ErrorState(
                            text: "retrieve_departures_error",
                            onRetry: onRetry
                        )
                    case .normal(let data):
                        FlightList(
                            flights: data.flights,
                            showLoadMore: query.wrappedValue.isEmpty,
                            onLoadMore: onLoadMore
                        )
                    }
                    Spacer()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("home_title")
                            .font(.title)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        DatePicker(selection: $selectedDate, displayedComponents: [.date]) {}
                        .onChange(of: selectedDate) {
                            onDateChange(selectedDate)
                        }
                    }
                }
                .padding()
            }
        }
    }
}

private struct FlightList: View {
    var flights: [FlightUIModel]
    var showLoadMore: Bool
    var onLoadMore: () -> Void
    
    var body: some View {
        LazyVStack {
            ForEach(flights) { flight in
                NavigationLink(value: flight) {
                    FlightListItem(uiModel: flight)
                        .padding(.bottom, Spacing.x2)
                }
                .foregroundStyle(.primary)
            }
            if showLoadMore {
                LoadingState()
                    .onAppear(perform: onLoadMore)
            }
        }
        .navigationDestination(for: FlightUIModel.self) { flight in
            FlightDetailsView(flightId: flight.id)
        }
    }
}

#Preview {
    let uiState: TypedUIState<FlightListUIModel> = .normal(
        data: FlightListUIModel(
            flights: [
                FlightUIModel(id: "1", name: "HV6935", destination: "Tirana", date: Date.now, isQueried: true),
                FlightUIModel(id: "2", name: "HV5685", destination: "Lanzarote", date: Date.now, isQueried: true),
                FlightUIModel(id: "3", name: "HV6673", destination: "Tenerife", date: Date.now, isQueried: true),
                FlightUIModel(id: "4", name: "DL7505", destination: "Tenerife", date: Date.now, isQueried: true),
            ]
        )
    )
    
    HomeViewContent(
        uiState: uiState,
        onDateChange: { _ in },
        onQueryChange: { _ in },
        onRetry: {},
        onLoadMore: {}
    )
}
