//
//  Assignment.swift
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
import UserNotifications

struct Assignment: Identifiable, Codable, Equatable {
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
