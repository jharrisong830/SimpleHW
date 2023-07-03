//
//  Theme.swift
//  SimpleHW
//
//  Created by John Graham on 6/26/23.
//

import SwiftUI

enum Theme: String, Codable, CaseIterable, Identifiable {
    case red
    case orange
    case yellow
    case green
    case turquoise
    case blue
    case purple
    case magenta

    var accentColor: Color {
        switch self {
        case .red, .orange, .yellow, .green, .turquoise, .blue, .purple, .magenta: return .black
        case _: return .white
        }
    }

    var mainColor: Color {
        Color(rawValue)
    }

    var name: String {
        rawValue.capitalized
    }

    var id: String {
        name
    }
}
