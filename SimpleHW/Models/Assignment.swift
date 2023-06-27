//
//  Assignment.swift
//  SimpleHW
//
//  Created by John Graham on 6/26/23.
//

import Foundation
import UserNotifications

struct Assignment: Identifiable, Codable {
    let id: UUID
    var name: String
    var notes: String
    var dueDate: Date
    var notifEnabled: Bool
    var notifDate: Date
    
    init(id: UUID=UUID(), name: String, notes: String, dueDate: Date, notifEnabled: Bool = false, notifDate: Date? = nil) {
        self.id=id
        self.name=name
        self.notes=notes
        self.dueDate=dueDate
        self.notifEnabled=notifEnabled
        self.notifDate = notifDate ?? dueDate
    }
    
    func isAlmostDue() -> Bool {
        return self.dueDate.timeIntervalSince1970 - Date().timeIntervalSince1970 < 86400
    }
    
    func getEODTime() -> Date {
        var components = Calendar.current.dateComponents(in: TimeZone.current, from: self.dueDate)
        components.hour = 23
        components.minute = 59
        components.second = 59
        return components.date!
    }
}

extension Assignment {
    static var emptyAssignment: Assignment {
        Assignment(name: "", notes: "", dueDate: Date())
    }
}

extension Assignment {
    static let sampleAssignments: [Assignment] =
    [
        Assignment(name: "HW 1", notes: "this is a note\n i am writing this for the class", dueDate: Date.init(timeIntervalSince1970: 1685663940)),
        Assignment(name: "Lab 1", notes: "", dueDate: Date())
    ]
}
