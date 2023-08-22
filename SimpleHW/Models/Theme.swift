//
//  Theme.swift
//  Copyright (C) 2023  John Graham
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <https://www.gnu.org/licenses/>.

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
