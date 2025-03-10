//
//  BookmarksView.swift
//  MyTerminal
//
//  Created by Mitchell Tol on 19/02/2025.
//

import SwiftUI

struct BookmarksView: View {
    @Environment(BookmarksViewModel.self) private var viewModel
    
    var body: some View {
        BookmarksContent(
            uiModel: viewModel.uiModel,
            onResume: viewModel.onResume
        )
    }
}

private struct BookmarksContent: View {
    var uiModel: BookmarksUIModel
    var onResume: () -> Void
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(uiModel.flights) { flight in
                        NavigationLink(value: flight) {
                            FlightListItem(uiModel: flight)
                                .padding(.bottom, Spacing.x2)
                        }
                        .foregroundStyle(.primary)
                    }
                    .navigationDestination(for: FlightUIModel.self) { flight in
                        BookmarkDetailsView(flightId: flight.id)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("bookmarks_title")
                            .font(.title)
                    }
                }
                .padding(.horizontal, Spacing.x3)
                .padding(.bottom, Spacing.x2)
            }
            .onAppear(perform: onResume)
        }
    }
}

#Preview {
    let uiModel = BookmarksUIModel(
        flights: [
            FlightUIModel(id: "1", name: "HV6935", destination: "Tirana", date: Date.now, isQueried: true),
            FlightUIModel(id: "2", name: "HV5685", destination: "Lanzarote", date: Date.now, isQueried: true),
            FlightUIModel(id: "3", name: "HV6673", destination: "Tenerife", date: Date.now, isQueried: true),
            FlightUIModel(id: "4", name: "DL7505", destination: "Tenerife", date: Date.now, isQueried: true),
        ]
    )
    
    BookmarksContent(uiModel: uiModel, onResume: {})
}
