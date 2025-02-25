//
//  LoadingState.swift
//  MyTerminal
//
//  Created by Mitchell Tol on 24/02/2025.
//

import SwiftUI

struct LoadingState: View {
    var body: some View {
        ZStack {
            ProgressView()
                .controlSize(.large)
        }
    }
}

#Preview {
    LoadingState()
}
