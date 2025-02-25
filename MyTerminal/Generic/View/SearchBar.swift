//
//  SearchBar.swift
//  MyTerminal
//
//  Created by Mitchell Tol on 24/02/2025.
//

import SwiftUI

struct SearchBar: View {
    @Binding var value: String
    var onChange: (String) -> Void
    
    var body: some View {
        TextField(text: $value) {
            Text("search_placeholder")
        }
        .textFieldStyle(.plain)
        .autocorrectionDisabled()
        .onChange(of: value, initial: false) { _, newValue in
            onChange(newValue)
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    @State static var value = ""
    
    static var previews: some View {
        SearchBar(value: $value, onChange: { _ in })
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
