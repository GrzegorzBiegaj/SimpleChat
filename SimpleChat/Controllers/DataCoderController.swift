//
//  DataCoderController.swift
//  SimpleChat
//
//  Created by Grzegorz Biegaj on 15.06.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import Foundation

protocol DataCoderControllerProtocol {

    func encode(data: Data) -> [Data]
    func decode(data: Data)
    var receivedDataClosure: ((Data) -> Void)? { get set }
}

protocol DataCoderDelegateProtocol: class {

    func receivedData(data: Data)
}

class DataCoderController: DataCoderControllerProtocol {

    // Header structure:
    // 0 byte - 11
    // 1 byte - 22
    // 2 byte - 33
    // 3 byte - chunk index high
    // 4 byte - chunk index low
    // 5 byte - chunk count high
    // 6 byte - chunk count low
    fileprivate var header: [UInt8] = [11, 22, 33, 0, 0, 0, 0]

    // chunkLen - depends on the server size
    fileprivate let chunkLen = 130000

    weak var delegate: DataCoderDelegateProtocol?
    var receivedDataClosure: ((Data) -> Void)?

    // MARK: - Public interface

    func encode(data: Data) -> [Data] {
        let data = createChunks(data: data)
        return addHeaders(data: data)
    }

    // Data is returned as a receivedDataClosure
    func decode(data: Data) {
        addChunk(data: data)
        if isDataCompleted && !isOutputError {
            let data = joinChanks(data: outputChunks)
            receivedDataClosure?(data)
            outputChunks = []
            isDataCompleted = false
            numberOfChunks = 0
        }
    }

    // MARK: - Private edcoder

    fileprivate func createChunks(data: Data) -> [Data] {
        var startIndex = 0
        var endIndex = 0
        var result: [Data] = []

        while startIndex < data.count {
            endIndex = startIndex + chunkLen - 1
            if endIndex > data.count - 1 {
                endIndex = data.count - 1
            }
            let tempData = data[startIndex...endIndex]
            result += [tempData]
            startIndex += chunkLen
        }
        return result
    }

    fileprivate func addHeaders(data: [Data]) -> [Data] {

        var result: [Data] = []
        for (index, item) in data.enumerated() {
            header[3] = UInt8(index >> 8)
            header[4] = UInt8(index & 0xff)
            header[5] = UInt8(data.count >> 8)
            header[6] = UInt8(data.count & 0xff)
            var tempData = Data(header)
            tempData.append(contentsOf: item)
            result += [tempData]
        }
        return result
    }

    // MARK: - Private decoder

    fileprivate var outputChunks: [Data] = []
    fileprivate var numberOfChunks = 0
    fileprivate var currentChunkNumber = 0
    fileprivate(set) var isOutputError = false
    fileprivate(set) var isDataCompleted = false

    fileprivate func addChunk(data: Data) {

        let headerConst = header[0...2]
        let inputConst = data[0...2]

        // Ignore other data than header
        guard NSData(data: Data(headerConst)).isEqual(to: inputConst) else { return }

        let elementIndex = Int((data[3] << 8) | data[4])
        let elementCount = Int((data[5] << 8) | data[6])

        print ("Received video package element: \(elementIndex + 1) of \(elementCount)")

        // First element resets decode mechanism and sets number of chunks
        if elementIndex == 0 {
            numberOfChunks = elementCount
            currentChunkNumber = 0
            outputChunks.removeAll()
            isOutputError = false
            isDataCompleted = false
        }

        // Protection against output error, or wrong chunk index
        if isOutputError == true || elementIndex > numberOfChunks - 1 || elementIndex != currentChunkNumber {
            numberOfChunks = 0
            currentChunkNumber = 0
            outputChunks.removeAll()
            isOutputError = true
            isDataCompleted = false
            return
        }

        // Add chunk to decode buffer
        if elementIndex == currentChunkNumber {
            outputChunks += [data[header.count...data.count - 1]]
        }

        // Set decode mechanism as completed if last chunk is added
        if (elementIndex == numberOfChunks - 1) {
            isDataCompleted = true
            return
        }

        currentChunkNumber += 1
    }

    fileprivate func joinChanks(data: [Data]) -> Data {
        var output: Data = Data()
        for item in data {
            output.append(item)
        }
        return output
    }

}
