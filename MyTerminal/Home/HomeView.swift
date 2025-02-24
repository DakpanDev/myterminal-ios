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
        HomeViewContent(uiState: viewModel.uiState)
            .onAppear {
                viewModel.observeFlightsByDay(day: Date.now)
            }
    }
}

private struct HomeViewContent: View {
    var uiState: TypedUIState<FlightListUIModel>

    var body: some View {
        
        NavigationStack {
            VStack {
                switch uiState {
                case .loading:
                    Text("Loading")
                case .normal:
                    Text("Normal")
                case .error:
                    Text("Error")
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Departing Flights")
                        .font(.largeTitle)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "calendar")
                }
            }
            .padding()
        }
    }
}

#Preview {
    let uiState: TypedUIState<FlightListUIModel> = .loading
    
    HomeViewContent(uiState: uiState)
}
