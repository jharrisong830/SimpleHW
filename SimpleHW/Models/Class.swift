//
//  Class.swift
//  SimpleHW
//
//  Created by John Graham on 6/26/23.
//

import Foundation
import SwiftUI

struct Class: Identifiable, Codable {
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
    
    var displayName: String {
        return self.code.isEmpty ? self.title : self.code
    }

    
    init(id: UUID = UUID(), title: String, code: String?, icon: Icon, theme: Theme, credits: Int, assignments: [Assignment]) {
        self.id=id
        self.title=title
        self.code=code ?? ""
        self.icon=icon
        self.theme=theme
        self.credits=credits
        self.assignments=assignments
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
