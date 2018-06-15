//
//  MessageController.swift
//  SimpleChat
//
//  Created by Grzegorz Biegaj on 14.06.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import Foundation

protocol MessageControllerProtocol {

    var messages: Messages { get }
    func add(message: Message)
    func removeAll()
}

class MessageController: MessageControllerProtocol {

    fileprivate let storage = InMemoryStorage.sharedInstance

    // MARK: - Public interface

    var messages: Messages {
        return getMessages ?? Messages(items: [])
    }

    func add(message: Message) {
        let localMessages = getMessages ?? Messages(items: [])
        storage.store(Messages(items: localMessages.items + [message]))
    }

    func removeAll() {
        storage.clear(Messages.self)
    }

    // MARK: - Private

    fileprivate var getMessages: Messages? {
        return storage.tryRestore()
    }


}
