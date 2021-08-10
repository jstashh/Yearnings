//
//  PreferredDisplayUnit.swift
//  Yearnings
//

//

import Foundation
import Combine

final class DisplayUnitContainer: ObservableObject {
    @Published var displayUnit: PreferredDisplayUnit = .dollar
}

enum PreferredDisplayUnit {
    case native
    case dollar

    mutating func toggle() {
        switch self {
        case .native:
            self = .dollar
        case .dollar:
            self = .native
        }
    }
}
