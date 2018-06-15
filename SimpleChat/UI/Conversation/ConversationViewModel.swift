//
//  ConversationViewModel.swift
//  SimpleChat
//
//  Created by Grzegorz Biegaj on 14.06.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import UIKit

class ConversationViewModel {

    let messageController: MessageControllerProtocol

    init(messageController: MessageControllerProtocol = MessageController()) {
        self.messageController = messageController
    }

    // MARK: - Public interface

    let title = "Simple Chat"
    let warningMessage = "Warning"
    let deleteAllMessage = "Do you want to delete the entire conversation?"
    let okButtonTitle = "OK"
    let cancelButtonTitle = "Cancel"

    func addSentText(text: String) {
        addMessage(message: Message(entry: .text(text), side: .sent, timeStamp: Date()))
    }

    func addReceivedText(text: String) {
        addMessage(message: Message(entry: .text(text), side: .received, timeStamp: Date()))
    }

    func removeAll() {
        messageController.removeAll()
    }

    struct KeyboardResult {
        let isShown: Bool
        let hight: CGFloat
        let animateDuration: TimeInterval
    }
    
    func isKeyboardShown(notification: NSNotification, view: UIView) -> KeyboardResult {
        guard let userInfo = notification.userInfo,
            let keyboardFrameEndUserInfoKey: NSValue = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
            let animateDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval,
            let viewFrame = view.window?.frame else { return KeyboardResult(isShown: false, hight: 0, animateDuration: 0) }

        let keyboardRect = keyboardFrameEndUserInfoKey.cgRectValue
        let viewRect = view.convert(viewFrame, from: nil)

        return KeyboardResult(isShown: keyboardRect.origin.y - viewRect.height == 0,
                              hight: keyboardRect.height,
                              animateDuration: animateDuration)
    }

    // MARK: - Private

    fileprivate func addMessage(message: Message) {
        messageController.add(message: message)
    }
    
}
