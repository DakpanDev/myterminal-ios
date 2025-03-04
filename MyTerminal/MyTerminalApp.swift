//
//  MyTerminalApp.swift
//  MyTerminal
//
//  Created by Mitchell Tol on 19/02/2025.
//

import SwiftUI
import SwiftData

@main
struct MyTerminalApp: App {
    @State private var homeViewModel = HomeViewModel()
    @State private var bookmarksViewModel = BookmarksViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainScreen()
                .environment(homeViewModel)
                .environment(bookmarksViewModel)
        }
    }
}
