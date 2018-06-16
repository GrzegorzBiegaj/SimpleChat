//
//  ConversationViewModelTests.swift
//  SimpleChatTests
//
//  Created by Grzegorz Biegaj on 16.06.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import XCTest
@testable import SimpleChat

class ConversationViewModelTests: XCTestCase {

    let messageControllerMock = MessageControllerMock()
    let fileControllerMock = FileControllerMock()

    func testAddSentText() {
        let conversationViewModel = ConversationViewModel(messageController: messageControllerMock, fileController: fileControllerMock)
        let message = Message(entry: .text("test"), side: .sent, timeStamp: Date())
        conversationViewModel.addSentText(text: "test")
        XCTAssertEqual(message.entry, messageControllerMock.messages.items.last!.entry)
        XCTAssertEqual(message.side, messageControllerMock.messages.items.last!.side)
    }

    func testAddReceivedText() {
        let conversationViewModel = ConversationViewModel(messageController: messageControllerMock, fileController: fileControllerMock)
        let message = Message(entry: .text("test2"), side: .received, timeStamp: Date())
        conversationViewModel.addReceivedText(text: "test2")
        XCTAssertEqual(message.entry, messageControllerMock.messages.items.last!.entry)
        XCTAssertEqual(message.side, messageControllerMock.messages.items.last!.side)
    }

    func testAddSentVideo() {
        let conversationViewModel = ConversationViewModel(messageController: messageControllerMock, fileController: fileControllerMock)
        let url = URL(string: "http://test.com")!
        let message = Message(entry: .video(url), side: .sent, timeStamp: Date())
        conversationViewModel.addSentVideo(url: url)
        XCTAssertEqual(message.entry, messageControllerMock.messages.items.last!.entry)
        XCTAssertEqual(message.side, messageControllerMock.messages.items.last!.side)
    }

    func testAddReceivedVideo() {
        let conversationViewModel = ConversationViewModel(messageController: messageControllerMock, fileController: fileControllerMock)
        let url = URL(string: "http://test.com")!
        let message = Message(entry: .video(url), side: .received, timeStamp: Date())
        conversationViewModel.addReceivedVideo(url: url)
        XCTAssertEqual(message.entry, messageControllerMock.messages.items.last!.entry)
        XCTAssertEqual(message.side, messageControllerMock.messages.items.last!.side)
    }

    func testRemoveAll() {
        let conversationViewModel = ConversationViewModel(messageController: messageControllerMock, fileController: fileControllerMock)
        let url = URL(string: "http://test.com")!
        conversationViewModel.addReceivedVideo(url: url)
        XCTAssertEqual(messageControllerMock.messages.items.count, 1)
        conversationViewModel.removeAll()
        XCTAssertEqual(messageControllerMock.messages.items.count, 0)
    }
}
