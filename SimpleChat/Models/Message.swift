//
//  Message.swift
//  SimpleChat
//
//  Created by Grzegorz Biegaj on 13.06.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import Foundation

struct Message {
    let entry: Entry
    let side: Side
    let timeStamp: Date
}

extension Message: Equatable {
    
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.entry == rhs.entry
            && lhs.side == rhs.side
            && lhs.timeStamp == rhs.timeStamp
    }
}

struct Messages {
    var items: [Message]
}

extension Messages: InMemoryStorable { }
