//
//  Class.swift
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
import SwiftUI

struct Class: Identifiable {
    let id: UUID
    var title: String
    var code: String
    var icon: Icon
    var theme: Theme
    var credits: Int
    var creditsAsDouble: Double {
        get {
            Double(credits)
        }
        set {
            credits=Int(newValue)
        }
    }
    var assignments: [Assignment]
    var orderedAssignments: [Assignment] {
        get {
            assignments.sorted(by: { $0.dueDate.compare($1.dueDate) == .orderedAscending })
        }
        set {
            assignments=newValue
        }
    }
    
    var numAlmostDue: Int {
        let boolArray = self.assignments.map {$0.isAlmostDue()}
        return boolArray.reduce(0, { x, y in
            x + (y ? 1 : 0)
        })
    }
    
    var assignmsWithNotifs: [Assignment] {
        return self.assignments.filter( { $0.notifEnabled } )
    }
    
    var completedAssignments: [Assignment]
    
    var displayName: String {
        return self.code.isEmpty ? self.title : self.code
    }

    
    init(id: UUID = UUID(), title: String, code: String?, icon: Icon, theme: Theme, credits: Int, assignments: [Assignment], completedAssignments: [Assignment]? = nil) {
        self.id=id
        self.title=title
        self.code=code ?? ""
        self.icon=icon
        self.theme=theme
        self.credits=credits
        self.assignments=assignments
        self.completedAssignments=completedAssignments ?? []
    }
}



extension Class {
    static var emptyCourse: Class {
        Class(title: "", code: "", icon: .terminal, theme: .green, credits: 0, assignments: [])
    }
}


extension Class {
    static let sampleClasses: [Class] =
    [
        Class(title: "Systems Programming", code: "CS 392", icon: .terminal, theme: .red, credits: 3, assignments: Assignment.sampleAssignments),
        Class(title: "Principles of Programming Languages", code: "CS 496", icon: .function, theme: .orange, credits: 3, assignments: []),
        Class(title: "Intermediate Statistics", code: "MA 331", icon: .book, theme: .yellow, credits: 3, assignments: [])
    ]
}




extension Class: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case code
        case icon
        case theme
        case credits
        case assignments
        case completedAssignments
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.id, forKey: .id)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.code, forKey: .code)
        try container.encode(self.icon, forKey: .icon)
        try container.encode(self.theme, forKey: .theme)
        try container.encode(self.credits, forKey: .credits)
        try container.encode(self.assignments, forKey: .assignments)
        try container.encode(self.completedAssignments, forKey: .completedAssignments)
    }


    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.id = try values.decode(UUID.self, forKey: .id)
        } catch {
            self.id = UUID()
        }
        
        do {
            self.title = try values.decode(String.self, forKey: .title)
        } catch {
            self.title = "READ_ERROR"
        }
        
        do {
            self.code = try values.decode(String.self, forKey: .code)
        } catch {
            self.code = "READ_ERROR"
        }
        
        do {
            self.icon = try values.decode(Icon.self, forKey: .icon)
        } catch {
            self.icon = .dots
        }
        
        do {
            self.theme = try values.decode(Theme.self, forKey: .theme)
        } catch {
            self.theme = .red
        }
        
        do {
            self.credits = try values.decode(Int.self, forKey: .credits)
        } catch {
            self.credits = 0
        }
        
        do {
            self.assignments = try values.decode([Assignment].self, forKey: .assignments)
        } catch {
            self.assignments = []
        }
        
        do {
            self.completedAssignments = try values.decode([Assignment].self, forKey: .completedAssignments)
        } catch {
            self.completedAssignments = []
        }
    }
}
