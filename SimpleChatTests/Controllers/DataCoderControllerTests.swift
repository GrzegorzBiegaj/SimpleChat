//
//  DataCoderControllerTests.swift
//  SimpleChatTests
//
//  Created by Grzegorz Biegaj on 16.06.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import XCTest
@testable import SimpleChat

class DataCoderControllerTests: XCTestCase {

    func testEncodeShortData() {

        let dataCoderController = DataCoderController()
        let input = Data([1, 2, 3, 4, 5])
        let output = Data([11, 22, 33, 0, 0, 0, 1, 1, 2, 3, 4, 5])
        let encodedData = dataCoderController.encode(data: input)

        XCTAssertEqual(encodedData.count, [output].count)
        XCTAssertEqual(encodedData[0].count, output.count)
        XCTAssertEqual(encodedData, [output])
    }

    func testEncodeLongData() {

        let dataCoderController = DataCoderController()
        let input = randomDataGenerator(count: 300000)
        let outputHeader1 = Data([11, 22, 33, 0, 0, 0, 3])
        let outputHeader2 = Data([11, 22, 33, 0, 1, 0, 3])
        let outputHeader3 = Data([11, 22, 33, 0, 2, 0, 3])
        let output1 = outputHeader1 + input[0...129999]
        let output2 = outputHeader2 + input[130000...259999]
        let output3 = outputHeader3 + input[260000...300000]

        let encodedData = dataCoderController.encode(data: input)

        XCTAssertEqual(encodedData.count, 3)
        XCTAssertEqual(encodedData[0].count, output1.count)
        XCTAssertEqual(encodedData[0], output1)
        XCTAssertEqual(encodedData[1].count, output2.count)
        XCTAssertEqual(encodedData[1], output2)
        XCTAssertEqual(encodedData[2].count, output3.count)
        XCTAssertEqual(encodedData[2], output3)
    }

    func testDecodeShortData() {

        let expectation = XCTestExpectation(description: "Decode data")
        let dataCoderController = DataCoderController()
        let input = Data([1, 2, 3, 4, 5])
        let encodedData = dataCoderController.encode(data: input)
        dataCoderController.receivedDataClosure = { data in
            XCTAssertEqual(input.count, data.count)
            XCTAssertEqual(input, data)
            XCTAssertEqual(dataCoderController.isDataCompleted, true)
            XCTAssertEqual(dataCoderController.isOutputError, false)
            expectation.fulfill()
        }
        dataCoderController.decode(data: encodedData[0])
    }

    func testDecodeLongData() {

        let expectation = XCTestExpectation(description: "Decode data")
        let dataCoderController = DataCoderController()
        let input = randomDataGenerator(count: 300000)
        let encodedData = dataCoderController.encode(data: input)
        dataCoderController.receivedDataClosure = { data in
            XCTAssertEqual(input.count, data.count)
            XCTAssertEqual(input, data)
            XCTAssertEqual(dataCoderController.isDataCompleted, true)
            XCTAssertEqual(dataCoderController.isOutputError, false)
            expectation.fulfill()
        }
        dataCoderController.decode(data: encodedData[0])
        dataCoderController.decode(data: encodedData[1])
        dataCoderController.decode(data: encodedData[2])
    }

    func testDecodeWrongChunk() {

        let expectation = XCTestExpectation(description: "Decode data")
        let dataCoderController = DataCoderController()
        let input = randomDataGenerator(count: 300000)
        let encodedData = dataCoderController.encode(data: input)
        dataCoderController.receivedDataClosure = { data in
            XCTFail()
            expectation.fulfill()
        }
        dataCoderController.decode(data: encodedData[0])
        XCTAssertEqual(dataCoderController.isDataCompleted, false)
        XCTAssertEqual(dataCoderController.isOutputError, false)

        // insert wrong chunk number (4 insted of 1)
        var chunk2 = encodedData[1]
        chunk2[4] = 5
        dataCoderController.decode(data: chunk2)
        XCTAssertEqual(dataCoderController.isDataCompleted, false)
        XCTAssertEqual(dataCoderController.isOutputError, true)

        // insert good chunk 1
        dataCoderController.decode(data: encodedData[1])
        XCTAssertEqual(dataCoderController.isDataCompleted, false)
        XCTAssertEqual(dataCoderController.isOutputError, true)

        // send one againg first chunk (should reset mechanism)
        dataCoderController.decode(data: encodedData[0])
        XCTAssertEqual(dataCoderController.isDataCompleted, false)
        XCTAssertEqual(dataCoderController.isOutputError, false)
    }

    // MARK: - Helper functions

    func randomDataGenerator(count: Int) -> Data {
        var data = Data()
        for _ in 0...count {
            data.append(randomInt)
        }
        return data
    }

    var randomInt: UInt8 {
        return UInt8(arc4random_uniform(UInt32(255)))
    }

}
