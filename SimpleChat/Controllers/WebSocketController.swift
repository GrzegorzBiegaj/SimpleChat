//
//  WebSocketController.swift
//  SimpleChat
//
//  Created by Grzegorz Biegaj on 13.06.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import Foundation
import SwiftWebSocket

protocol WebSocketControllerDelegate: class {

    func didOpen()
    func didClose()
    func didReceiveError(error: Error)
    func didReceiveString(text: String)
    func didReceiveData(data: NSData)
}

class WebSocketController {

    let webSocket: WebSocket

    weak var delegate: WebSocketControllerDelegate?

    init() {
        self.webSocket = WebSocket("ws://echo.websocket.org")
        self.webSocket.delegate = self
        self.webSocket.binaryType = .nsData
    }

    func sendText(text: String) {
        webSocket.send(text)
    }

    func sendData(data: NSData) {
        webSocket.send(data)
    }

    func open() {
        webSocket.open()
        self.webSocket.delegate = self
        self.webSocket.binaryType = .nsData
    }

}

extension WebSocketController: WebSocketDelegate {

    func webSocketOpen() {
        print("webSocketOpen")
        delegate?.didOpen()
    }

    func webSocketClose(_ code: Int, reason: String, wasClean: Bool) {
        print("webSocketClose: code: \(code), reason: \(reason), wasClean: \(wasClean)")
        delegate?.didClose()
        open()
    }

    func webSocketError(_ error: NSError) {
        print("webSocketError: \(error)")
        delegate?.didReceiveError(error: error)
        open()
    }

    func webSocketMessageText(_ text: String) {
        delegate?.didReceiveString(text: text)
    }

    func webSocketMessageData(_ data: Data) {
        delegate?.didReceiveData(data: NSData(data: data))
    }

}
