//
//  MainScreen.swift
//  MyTerminal
//
//  Created by Mitchell Tol on 19/02/2025.
//

import SwiftUI

struct MainScreen: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                        .accessibilityIdentifier("home")
                }

            BookmarksView()
                .tabItem {
                    Label("Bookmarks", systemImage: "list.clipboard")
                        .accessibilityIdentifier("bookmarks")
                }
        }
    }
}

#Preview {
    MainScreen()
}
