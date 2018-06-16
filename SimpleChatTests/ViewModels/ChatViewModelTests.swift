//
//  ChatViewModelTests.swift
//  SimpleChatTests
//
//  Created by Grzegorz Biegaj on 16.06.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import XCTest
@testable import SimpleChat

class ChatViewModelTests: XCTestCase {

    func testMessageVM() {

        let dateTimeControllerMock = DateTimeControllerMock()
        let messageSent = Message(entry: .text("test1"), side: .sent, timeStamp: Date())
        let messageVMSent = MessageVM(message: messageSent, dateTimeController: dateTimeControllerMock)
        let avatarSent = Avatar(character: "S", backgroundColor: .darkGreen, fontColor: .white)

        XCTAssertEqual(messageVMSent.message, messageSent)
        XCTAssertEqual(messageVMSent.avatar, avatarSent)
        XCTAssertEqual(messageVMSent.time, "test")

        let messageReceived = Message(entry: .text("test2"), side: .received, timeStamp: Date())
        let messageVMReceived = MessageVM(message: messageReceived, dateTimeController: dateTimeControllerMock)
        let avatarReceived = Avatar(character: "R", backgroundColor: .yellow, fontColor: .black)

        XCTAssertEqual(messageVMReceived.message, messageReceived)
        XCTAssertEqual(messageVMReceived.avatar, avatarReceived)
        XCTAssertEqual(messageVMReceived.time, "test")
    }

    func testChatsAndEmpty() {

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let date = formatter.date(from: "2018/05/05 12:33")

        let messageControllerMock = MessageControllerMock()
        let chatViewModel = ChatViewModel(messageController: messageControllerMock)
        XCTAssertTrue(chatViewModel.isChatEmpty)

        let messageSent = Message(entry: .text("test1"), side: .sent, timeStamp: date!)
        let messageReceived = Message(entry: .text("test2"), side: .received, timeStamp: date!)
        messageControllerMock.add(message: messageSent)
        messageControllerMock.add(message: messageReceived)
        let avatarSent = Avatar(character: "S", backgroundColor: .darkGreen, fontColor: .white)
        let avatarReceived = Avatar(character: "R", backgroundColor: .yellow, fontColor: .black)

        XCTAssertEqual(chatViewModel.chats.count, 2)
        XCTAssertEqual(chatViewModel.chats[0].avatar, avatarSent)
        XCTAssertEqual(chatViewModel.chats[0].message, messageSent)
        XCTAssertEqual(chatViewModel.chats[0].time, "5 May, 12:33 PM")
        XCTAssertEqual(chatViewModel.chats[1].avatar, avatarReceived)
        XCTAssertEqual(chatViewModel.chats[1].message, messageReceived)
        XCTAssertEqual(chatViewModel.chats[1].time, "5 May, 12:33 PM")
        XCTAssertFalse(chatViewModel.isChatEmpty)
    }
}
