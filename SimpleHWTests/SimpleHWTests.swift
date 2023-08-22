//
//  SimpleHWTests.swift
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

import XCTest
import Foundation
@testable import SimpleHW

final class SimpleHWTests: XCTestCase {
    
    var assignments1: [Assignment] = []
    var assignments2: [Assignment] = []
    var classes: [Class] = []

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        assignments1 = [
            Assignment(name: "HW1", notes: "Hello this is a note!", dueDate: Date()),
            Assignment(name: "Test 1", notes: "", dueDate: Date().advanced(by: 86000))
        ]
        assignments2 = [
            Assignment(name: "Reading ch1", notes: "up to pg 40", dueDate: Date(), notifEnabled: true, notifDate: Date().advanced(by: 3600)),
            Assignment(name: "Final Exam", notes: "", dueDate: Date(), notifEnabled: false)
        ]
        
        classes = [
            Class(title: "CS", code: nil, icon: .terminal, theme: .red, credits: 3, assignments: []),
            Class(title: "Math", code: "MA 101", icon: .function, theme: .green, credits: 4, assignments: assignments1),
            Class(title: "English", code: "ENG", icon: .book, theme: .blue, credits: 9, assignments: assignments2)
        ]
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testProperties() throws {
        // Tests the properties of classes and assignments to ensure they are computed correctly
        
        XCTAssertNotNil(classes[0].code) // should default to "" if nil
        XCTAssertEqual(classes[0].code, "")
        
        XCTAssertEqual(classes[0].displayName, classes[0].title) // when no nickname (code) given, display name should be title
        
        XCTAssertEqual(classes[1].displayName, classes[1].code) // display name should be same as code when given
        XCTAssertNotEqual(classes[1].displayName, classes[1].title)
        
        // TODO: add more
    }
}
