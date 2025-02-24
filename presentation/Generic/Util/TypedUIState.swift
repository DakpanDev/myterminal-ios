//
//  TypedUIState.swift
//  Presentation
//
//  Created by Mitchell Tol on 19/02/2025.
//

import Foundation

enum TypedUIState<T> {
    case normal(data: T)
    case loading
    case error
}

extension TypedUIState {
    
    func normalDataOrNil() -> T? {
        return switch self {
        case .normal(let data): data
        default: nil
        }
    }
}
