//
//  MessageControllerTests.swift
//  SimpleChatTests
//
//  Created by Grzegorz Biegaj on 16.06.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import XCTest
@testable import SimpleChat

class MessageControllerTests: XCTestCase {
    
    func testEmptyMessages() {

        let messageController = MessageController()
        messageController.removeAll()
        XCTAssertEqual(messageController.messages.items.count, 0)
        XCTAssertEqual(messageController.messages.items, [])
    }

    func testAddMessages() {

        let messageController = MessageController()
        messageController.removeAll()
        let message1 = Message(entry: .text("test text"), side: .received, timeStamp: Date())
        let message2 = Message(entry: .video(URL(string: "http://test.com")!), side: .sent, timeStamp: Date())
        messageController.add(message: message1)
        XCTAssertEqual(messageController.messages.items, [message1])
        XCTAssertEqual(messageController.messages.items.count, 1)
        messageController.add(message: message2)
        XCTAssertEqual(messageController.messages.items, [message1, message2])
        XCTAssertEqual(messageController.messages.items.count, 2)
    }

    func testRemoveAllMessages() {

        let messageController = MessageController()
        messageController.removeAll()
        let message1 = Message(entry: .text("test text"), side: .received, timeStamp: Date())
        let message2 = Message(entry: .video(URL(string: "http://test.com")!), side: .sent, timeStamp: Date())
        messageController.add(message: message1)
        messageController.add(message: message2)
        XCTAssertEqual(messageController.messages.items, [message1, message2])
        XCTAssertEqual(messageController.messages.items.count, 2)
        messageController.removeAll()
        XCTAssertEqual(messageController.messages.items.count, 0)
        XCTAssertEqual(messageController.messages.items, [])
    }
    
}
