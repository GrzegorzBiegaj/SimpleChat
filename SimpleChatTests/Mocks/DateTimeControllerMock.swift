//
//  DateTimeControllerMock.swift
//  SimpleChatTests
//
//  Created by Grzegorz Biegaj on 16.06.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import Foundation
@testable import SimpleChat

class DateTimeControllerMock: DateTimeControllerProtocol {

    func getDateTimeString(timestamp: Date) -> String {
        return "test"
    }

    func getDateTimeLongString(timestamp: Date) -> String {
        return "test"
    }

}
