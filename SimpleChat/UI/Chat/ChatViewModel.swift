//
//  ChatViewModel.swift
//  SimpleChat
//
//  Created by Grzegorz Biegaj on 14.06.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import Foundation

struct ChatVM {

    let chats: [MessageVM]

    init (messages: [Message]) {
        chats = messages.map { MessageVM(message: $0) }
    }
}

struct MessageVM {

    let message: Message
    let avatar: Avatar
    let time: String

    init(message: Message) {

        let dateTimeController = DateTimeController()

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
    
    var chats: ChatVM {
        return ChatVM(messages: messageController.messages.items)
    }

    var isChatEmpty: Bool {
        return chats.chats.count == 0
    }

}
