//
//  Entry.swift
//  SimpleChat
//
//  Created by Grzegorz Biegaj on 16.06.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import Foundation

enum Side {
    case sent
    case received
}

extension Side: Equatable {

    static func == (lhs: Side, rhs: Side) -> Bool {
        switch (lhs, rhs) {
        case (.sent, .sent): return true
        case (.received, .received): return true
        default: return false
        }
    }
}

enum Entry {
    case text(String)
    case video(URL)
}

extension Entry: Equatable {
    
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        switch (lhs, rhs) {
        case (let .text(string1), let .text(string2)):
            return string1 == string2
        case (let .video(url1), let .video(url2)):
            return url1 == url2
        default:
            return false
        }
    }
}
