//
//  FlightDetailsView.swift
//  MyTerminal
//
//  Created by Mitchell Tol on 24/02/2025.
//

import SwiftUI

struct FlightDetailsView: View {
    @State private var viewModel: DetailsViewModel
    
    init(flightId: String) {
        let args = DetailsViewModelArgs(flightId: flightId)
        _viewModel = State(wrappedValue: DetailsViewModel(args: args))
    }
    
    var body: some View {
        ScrollView {
            DetailsViewContent(
                uiState: viewModel.uiState,
                onRetry: viewModel.onRetry
            )
            .padding(.top, Spacing.x2)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                viewModel.uiState.showIfNormal { data in
                    Image(systemName: data.isBookmarked ? "bookmark.fill" : "bookmark")
                        .onTapGesture(perform: viewModel.onBookmark)
                }
            }
        }
    }
}

struct DetailsViewContent: View {
    var uiState: TypedUIState<DetailsUIModel>
    var onRetry: () -> Void

    var body: some View {
        switch uiState {
        case .error:
            ErrorState(
                text: "An error has occurred while retrieving flight details",
                onRetry: onRetry
            )
        case .loading:
            LoadingState()
        case .normal(let data):
            NormalContent(uiModel: data)
        }
    }
}

private struct NormalContent: View {
    var uiModel: DetailsUIModel
    
    var body: some View {
        VStack {
            GeneralDetails(
                flightName: uiModel.name,
                destination: uiModel.destination,
                states: uiModel.states,
                departureDate: uiModel.departureDateTime
            )
        }
    }
}

#Preview {
    let uiState: TypedUIState<DetailsUIModel> = .normal(
        data: DetailsUIModel(
            id: "flight_id",
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
    )
    DetailsViewContent(
        uiState: uiState,
        onRetry: {}
    )
}
