//
//  Icon.swift
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

import Foundation


enum Icon: String, Codable, CaseIterable, Identifiable {
    case dots
    case terminal
    case function
    case book
    case paper
    case paintbrush
    case people
    case activity
    case network
    case globe
    case astronomy
    case weather
    case electricity
    case gears
    case theater
    case building
    case processor
    case testtubes
    case leaf
    case lens
    case graph
    case controller
    case palette
    case atom
    case sum
    case braces
    case money
    case star
    case heart
    case root
    case operands
    case percent
    case angle
    case scribble
    case coordinates
    
    
    var symbol: String {
        switch self {
        case .dots: return "aqi.medium"
        case .terminal: return "terminal.fill"
        case .function: return "function"
        case .book: return "books.vertical.fill"
        case .paper: return "doc.append.fill"
        case .paintbrush: return "paintbrush.pointed.fill"
        case .people: return "person.3.sequence.fill"
        case .activity: return "figure.run"
        case .network: return "network"
        case .globe: return "globe.americas.fill"
        case .astronomy: return "moon.stars.fill"
        case .weather: return "cloud.sun.rain.fill"
        case .electricity: return "bolt.fill"
        case .gears: return "gearshape.2.fill"
        case .theater: return "theatermasks.fill"
        case .building: return "building.columns.fill"
        case .processor: return "cpu.fill"
        case .testtubes: return "testtube.2"
        case .leaf: return "leaf.fill"
        case .lens: return "camera.aperture"
        case .graph: return "chart.bar.xaxis"
        case .controller: return "gamecontroller.fill"
        case .palette: return "paintpalette.fill"
        case .atom: return "atom"
        case .sum: return "sum"
        case .braces: return "curlybraces"
        case .money: return "dollarsign"
        case .star: return "star.fill"
        case .heart: return "heart.fill"
        case .root: return "x.squareroot"
        case .operands: return "plus.forwardslash.minus"
        case .percent: return "percent"
        case .angle: return "angle"
        case .scribble: return "scribble.variable"
        case .coordinates: return "move.3d"
        }
    }
    
    var name: String {
        rawValue.capitalized
    }
    
    var id: String {
        name
    }
    
}
