//
//  EntryTests.swift
//  SimpleChatTests
//
//  Created by Grzegorz Biegaj on 16.06.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import XCTest
@testable import SimpleChat

class EntryTests: XCTestCase {

    func testSideEquatable() {
        let side1 = Side.received
        let side2 = Side.received
        let side3 = Side.sent
        let side4 = Side.sent

        XCTAssertEqual(side1, side2)
        XCTAssertEqual(side3, side4)
        XCTAssertNotEqual(side1, side3)
        XCTAssertNotEqual(side2, side4)
    }

    func testEntryEquatable() {
        let entry1 = Entry.text("test")
        let entry2 = Entry.text("test")
        let entry3 = Entry.text("testX")
        let entry4 = Entry.video(URL(string: "http://test.com")!)
        let entry5 = Entry.video(URL(string: "http://test.com")!)
        let entry6 = Entry.video(URL(string: "http://mytest.com")!)

        XCTAssertEqual(entry1, entry2)
        XCTAssertEqual(entry4, entry5)
        XCTAssertNotEqual(entry1, entry3)
        XCTAssertNotEqual(entry1, entry4)
        XCTAssertNotEqual(entry4, entry6)
    }
    
}
