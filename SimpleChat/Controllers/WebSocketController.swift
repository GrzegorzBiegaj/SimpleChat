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
    func didReceiveData(data: Data)
}

class WebSocketController {

    // MARK: - Public interface

    let webSocket: WebSocket
    var coderController: DataCoderControllerProtocol

    weak var delegate: WebSocketControllerDelegate?

    init(coderController: DataCoderControllerProtocol = DataCoderController()) {
        self.coderController = coderController
        self.webSocket = WebSocket("ws://echo.websocket.org")
        self.webSocket.delegate = self
        self.webSocket.binaryType = .nsData
        self.coderController.delegate = self
    }

    func sendText(text: String) {
        webSocket.send(text)
    }

    func sendData(url: URL) {
        DispatchQueue.global(qos: .utility).async {
            do {
                let data = try Data(contentsOf: url)
                self.sendDataChunks(data: data)
            } catch {
                // data reading error from url
            }
        }
    }

    func sendData(data: Data) {
        sendDataChunks(data: data)
    }

    func open() {
        webSocket.open()
        self.webSocket.delegate = self
        self.webSocket.binaryType = .nsData
    }

    // MARK: - Private

    fileprivate func sendDataChunks(data: Data) {
        print ("Input video size: \(data.count)")
        DispatchQueue.global(qos: .utility).async {
            let dataChunks = self.coderController.encode(data: data)
            for dataChunk in dataChunks {
                self.webSocket.send(dataChunk)
            }
        }
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
        DispatchQueue.global(qos: .utility).async {
            self.coderController.decode(data: data)
        }
    }

}

extension WebSocketController: DataCoderDelegateProtocol {

    func receivedData(data: Data) {
        print ("Output video size: \(data.count)")
        delegate?.didReceiveData(data: data)
    }


}
