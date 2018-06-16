//
//  ChatViewModel.swift
//  SimpleChat
//
//  Created by Grzegorz Biegaj on 14.06.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import Foundation

struct MessageVM {
    let message: Message
    let avatar: Avatar
    let time: String

    let dateTimeController: DateTimeControllerProtocol

    init(message: Message, dateTimeController: DateTimeControllerProtocol = DateTimeController()) {
        self.dateTimeController = dateTimeController

        self.message = message
        if case .received = message.side {
            self.avatar = Avatar(character: "R", backgroundColor: .yellow, fontColor: .black)
        } else {
            self.avatar = Avatar(character: "S", backgroundColor: .darkGreen, fontColor: .white)
        }
        time = dateTimeController.getDateTimeLongString(timestamp: message.timeStamp)
    }
}

class ChatViewModel {
    let messageController: MessageControllerProtocol

    init(messageController: MessageControllerProtocol = MessageController()) {
        self.messageController = messageController
    }

    // MARK: - Public interface

    var chats: [MessageVM] {
        return messageController.messages.items.map { MessageVM(message: $0) }
    }

    var isChatEmpty: Bool {
        return chats.count == 0
    }

}
