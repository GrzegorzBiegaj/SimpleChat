//
//  MessageTests.swift
//  SimpleChatTests
//
//  Created by Grzegorz Biegaj on 16.06.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import XCTest
@testable import SimpleChat

class MessageTests: XCTestCase {
    
    func testMessageEquatable() {
        let entry1 = Entry.text("test")
        let entry2 = Entry.video(URL(string: "http://test.com")!)
        let side1 = Side.received
        let side2 = Side.sent
        let date = Date()
        let message1 = Message(entry: entry1, side: side1, timeStamp: date)
        let message2 = Message(entry: entry1, side: side1, timeStamp: date)
        let message3 = Message(entry: entry2, side: side2, timeStamp: date)

        XCTAssertEqual(message1, message2)
        XCTAssertNotEqual(message1, message3)

        let message4 = Message(entry: entry1, side: side2, timeStamp: date)
        let message5 = Message(entry: entry1, side: side2, timeStamp: date)

        XCTAssertEqual(message4, message5)
    }
    
}
