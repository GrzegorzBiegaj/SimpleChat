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
        self.coderController.receivedDataClosure = { [unowned self] data in
            print ("Received video size: \(data.count)")
            DispatchQueue.main.async { [unowned self] in
                self.delegate?.didReceiveData(data: data)
            }
        }
    }

    func sendText(text: String) -> Bool {
        if isOpened {
            print("Send text message: \(text)")
            webSocket.send(text)
        } else {
            print("SendText error - connection is not opened")
        }
        return isOpened
    }

    func sendData(url: URL) -> Bool {
        if isOpened {
            do {
                let data = try Data(contentsOf: url)
                self.sendDataChunks(data: data)
            } catch {
                print("SendData error - wrong file path")
            }
        } else {
            print("SendData error - connection is not opened")
        }
        return isOpened
    }

    func sendData(data: Data) -> Bool {
        if isOpened {
            sendDataChunks(data: data)
        } else {
            print("SendData error - connection is not opened")
        }
        return isOpened
    }

    func open() {
        webSocket.open()
        self.webSocket.delegate = self
        self.webSocket.binaryType = .nsData
    }

    // MARK: - Private

    fileprivate func sendDataChunks(data: Data) {
        print ("Send video size: \(data.count)")
        DispatchQueue.global(qos: .utility).async { [unowned self] in
            let dataChunks = self.coderController.encode(data: data)
            for dataChunk in dataChunks {
                self.webSocket.send(dataChunk)
            }
        }
    }

    var isOpened: Bool {
        if case .open = webSocket.readyState {
            return true
        }
        return false
    }

}

extension WebSocketController: WebSocketDelegate {

    func webSocketOpen() {
        print("WebSocketOpen")
        delegate?.didOpen()
    }

    func webSocketClose(_ code: Int, reason: String, wasClean: Bool) {
        print("WebSocketClose: code: \(code), reason: \(reason), wasClean: \(wasClean)")
        delegate?.didClose()
        open()
    }

    func webSocketError(_ error: NSError) {
        print("WebSocketError: \(error)")
        delegate?.didReceiveError(error: error)
        open()
    }

    func webSocketMessageText(_ text: String) {
        print("Received text message: \(text)")
        delegate?.didReceiveString(text: text)
    }

    func webSocketMessageData(_ data: Data) {
        DispatchQueue.global(qos: .utility).async { [unowned self] in
            self.coderController.decode(data: data)
        }
    }

}
