//
//  ChatTableViewCell.swift
//  SimpleChat
//
//  Created by Grzegorz Biegaj on 13.06.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import UIKit

class ChatTextTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var avatarView: AvatarView!
    @IBOutlet weak var chatLabel: UILabel!
    @IBOutlet weak var bubbleView: BubbleView!
    @IBOutlet weak var timestampLabel: UILabel!

    var message: MessageVM? {

        didSet {
            guard let message = message, case .text(let text) = message.message.entry else { return }
            chatLabel.text = text
            bubbleView.side = message.message.side
            chatLabel.textColor = message.message.side == .received ? .darkGray : .white
            avatarView.avatar = message.avatar
            timestampLabel.textColor = .black
            timestampLabel.text = message.time
            backgroundColor = .silverGrey
        }
    }
    
}
