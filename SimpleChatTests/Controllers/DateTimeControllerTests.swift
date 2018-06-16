//
//  DateTimeControllerTests.swift
//  SimpleChatTests
//
//  Created by Grzegorz Biegaj on 12.06.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import XCTest
@testable import SimpleChat

class DateTimeControllerTests: XCTestCase {
    
    func testDateTimeLongString() {

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let date = formatter.date(from: "2018/05/05 12:33")

        let dateTimeController = DateTimeController()
        let dateStr = dateTimeController.getDateTimeLongString(timestamp: date!)
        XCTAssertEqual(dateStr, "5 May, 12:33 PM")
    }

    func testDateTimeString() {

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let date = formatter.date(from: "2018/05/05 12:33")

        let dateTimeController = DateTimeController()
        let dateStr = dateTimeController.getDateTimeString(timestamp: date!)
        XCTAssertEqual(dateStr, "5 May")
    }


    
}
