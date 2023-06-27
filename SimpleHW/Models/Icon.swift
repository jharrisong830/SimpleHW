//
//  Icon.swift
//  SimpleHW
//
//  Created by John Graham on 6/26/23.
//

import Foundation


enum Icon: String, Codable, CaseIterable, Identifiable {
    case terminal
    case function
    case book
    case paper
    case paintbrush
    case people
    case activity
    case medal
    case network
    case globe
    case astronomy
    case weather
    case media
    case microphone
    case shield
    case electricity
    case communication
    case gears
    case hammer
    case stethoscope
    case theater
    case building
    case lights
    case mountains
    case processor
    case antenna
    case plane
    case car
    case microbe
    case pills
    case health
    case testtubes
    case fish
    case leaf
    case lens
    case graph
    case controller
    case palette
    case atom
    case sum
    case braces
    case money
    case heart
    case dots
    
    
    var symbol: String {
        switch self {
        case .terminal: return "terminal.fill"
        case .function: return "function"
        case .book: return "books.vertical.fill"
        case .paper: return "doc.append.fill"
        case .paintbrush: return "paintbrush.pointed.fill"
        case .people: return "person.3.sequence.fill"
        case .activity: return "figure.run"
        case .medal: return "medal.fill"
        case .network: return "network"
        case .globe: return "globe.americas.fill"
        case .astronomy: return "moon.stars.fill"
        case .weather: return "cloud.sun.rain.fill"
        case .media: return "playpause.fill"
        case .microphone: return "mic.fill"
        case .shield: return "shield.lefthalf.fill"
        case .electricity: return "bolt.fill"
        case .communication: return "phone.bubble.left.fill"
        case .gears: return "gearshape.2.fill"
        case .hammer: return "hammer.fill"
        case .stethoscope: return "stethoscope"
        case .theater: return "theatermasks.fill"
        case .building: return "building.columns.fill"
        case .lights: return "lightbulb.led.fill"
        case .mountains: return "mountain.2.fill"
        case .processor: return "cpu.fill"
        case .antenna: return "antenna.radiowaves.left.and.right"
        case .plane: return "airplane"
        case .car: return "car.fill"
        case .microbe: return "microbe.fill"
        case .pills: return "pills.fill"
        case .health: return "cross.vial.fill"
        case .testtubes: return "testtube.2"
        case .fish: return "fish.fill"
        case .leaf: return "leaf.fill"
        case .lens: return "camera.aperture"
        case .graph: return "chart.bar.xaxis"
        case .controller: return "gamecontroller.fill"
        case .palette: return "paintpalette.fill"
        case .atom: return "atom"
        case .sum: return "sum"
        case .braces: return "curlybraces"
        case .money: return "dollarsign"
        case .heart: return "heart.fill"
        case .dots: return "aqi.medium"
        }
    }
    
    var name: String {
        rawValue.capitalized
    }
    
    var id: String {
        name
    }
    
}
