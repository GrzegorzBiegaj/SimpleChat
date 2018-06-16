//
//  MessageControllerMock.swift
//  SimpleChatTests
//
//  Created by Grzegorz Biegaj on 16.06.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import Foundation
@testable import SimpleChat

class MessageControllerMock: MessageControllerProtocol {

    var messages: Messages = Messages(items: [])

    func add(message: Message) {
        messages.items.append(message)
    }

    func removeAll() {
        messages.items.removeAll()
    }

}
