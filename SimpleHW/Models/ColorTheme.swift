//
//  ColorTheme.swift
//  SimpleHW
//
//  Created by John Graham on 6/29/23.
//

import Foundation
import SwiftUI

struct ColorTheme: Identifiable, Codable {
    let id: UUID
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
    
    init(id: UUID = UUID(), red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.id = id
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    var colorProperty: Color {
        get {
            Color(red: self.red, green: self.green, blue: self.blue)
        }
        set {
            print(newValue.description)
            self.red = 0
            self.green = 0
            self.blue = 0
        }
    }
}
