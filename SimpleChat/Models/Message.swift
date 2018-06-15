//
//  Message.swift
//  SimpleChat
//
//  Created by Grzegorz Biegaj on 13.06.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import Foundation

enum Side {
    case sent
    case received
}

enum Entry {
    case text(String)
    case movie(URL)
}

struct Message {
    let entry: Entry
    let side: Side
    let timeStamp: Date
}

struct Messages {
    var items: [Message]
}

extension Messages: InMemoryStorable { }
