//
//  Theme.swift
//  SimpleHW
//
//  Created by John Graham on 6/26/23.
//

import SwiftUI

enum Theme: String, Codable, CaseIterable, Identifiable {
//    case bubblegum
//    case buttercup
//    case indigo
//    case lavender
//    case magenta
//    case navy
//    case orange
//    case oxblood
//    case periwinkle
//    case poppy
//    case purple
//    case seafoam
//    case sky
//    case tan
//    case teal
//    case yellow
    case red
    case orange
    case yellow
    case green
    case turquoise
    case blue
    case purple
    case magenta

    var accentColor: Color {
        Color.black
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
