//
//  DataCoderControllerMock.swift
//  SimpleChatTests
//
//  Created by Grzegorz Biegaj on 16.06.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import Foundation
@testable import SimpleChat

class DataCoderControllerMock: DataCoderControllerProtocol {

    func encode(data: Data) -> [Data] {
        return [data]
    }

    func decode(data: Data) {
        outputClosure?(data)
    }

    var delegate: DataCoderDelegateProtocol?

    var outputClosure: ((Data) -> Void)?
}
