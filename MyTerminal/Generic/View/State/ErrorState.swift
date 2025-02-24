//
//  ErrorState.swift
//  MyTerminal
//
//  Created by Mitchell Tol on 24/02/2025.
//

import SwiftUI

struct ErrorState: View {
    var text: String
    var onRetry: () -> Void
    
    var body: some View {
        VStack(spacing: Spacing.x2) {
            Image(systemName: "exclamationmark.circle")
                .resizable()
                .frame(width: 40, height: 40)
            
            Text(text)
                .multilineTextAlignment(.center)
            
            Button(action: onRetry) {
                Text("Retry")
            }
        }
    }
}

#Preview {
    ErrorState(
        text: "An error has occurred while retrieving departures",
        onRetry: {}
    )
}
