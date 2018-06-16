//
//  DateTimeController.swift
//  SimpleChat
//
//  Created by Grzegorz Biegaj on 14.06.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import Foundation

protocol DateTimeControllerProtocol {

    func getDateTimeString(timestamp: Date) -> String
    func getDateTimeLongString(timestamp: Date) -> String
}

class DateTimeController: DateTimeControllerProtocol {

    fileprivate let dateTimeFormatter = DateFormatter()

    // MARK: - Public interface

    func getDateTimeString(timestamp: Date) -> String {

        return NSCalendar.current.isDateInToday(timestamp) ? getTimeString(timestamp: timestamp) : getDateString(timestamp: timestamp)
    }

    func getDateTimeLongString(timestamp: Date) -> String {

        if NSCalendar.current.isDateInToday(timestamp) {
            return getTimeString(timestamp: timestamp)
        } else {
            return ("\(getDateString(timestamp: timestamp)), \(getTimeString(timestamp: timestamp))")
        }
    }

    // MARK: - Private

    fileprivate func getTimeString(timestamp: Date) -> String {

        dateTimeFormatter.timeStyle = .none
        dateTimeFormatter.timeStyle = .short
        return dateTimeFormatter.string(from: timestamp)
    }

    fileprivate func getDateString(timestamp: Date) -> String {

        dateTimeFormatter.dateFormat = "d MMM"
        return dateTimeFormatter.string(from: timestamp)
    }

}
