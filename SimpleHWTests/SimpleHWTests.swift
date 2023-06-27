//
//  SimpleHWTests.swift
//  SimpleHWTests
//
//  Created by John Graham on 6/27/23.
//

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
