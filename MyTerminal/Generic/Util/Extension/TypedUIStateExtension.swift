//
//  TypedUIStateExtension.swift
//  MyTerminal
//
//  Created by Mitchell Tol on 24/02/2025.
//

import Foundation
import SwiftUI

extension TypedUIState {
    
    func showIfNormal<Content: View>(@ViewBuilder content: (T) -> Content) -> Content? {
        return if let data = normalDataOrNil() {
            content(data)
        } else {
            nil
        }
    }
}
