//
//  BookmarkDetailsView.swift
//  MyTerminal
// //  Created by Mitchell Tol on 04/03/2025.
//

import Foundation
import SwiftUI

struct BookmarkDetailsView: View {
    @State private var viewModel: BookmarkDetailsViewModel
    
    init(flightId: String) {
        let args = BookmarkDetailsViewModelArgs(flightId: flightId)
        _viewModel = State(wrappedValue: BookmarkDetailsViewModel(args: args))
    }
    
    var body: some View {
        ScrollView {
            DetailsViewContent(
                uiState: viewModel.uiState,
                onRetry: viewModel.onRetry
            )
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
