//
//  Avatar.swift
//  SimpleChat
//
//  Created by Grzegorz Biegaj on 16.06.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import UIKit

struct Avatar {

    let character: Character
    let backgroundColor: UIColor
    let fontColor: UIColor
}

extension Avatar: Equatable {

    static func == (lhs: Avatar, rhs: Avatar) -> Bool {
        return lhs.character == rhs.character
            && lhs.backgroundColor == rhs.backgroundColor
            && lhs.fontColor == rhs.fontColor
    }
}
