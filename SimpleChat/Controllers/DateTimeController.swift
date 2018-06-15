//
//  DateTimeController.swift
//  SimpleChat
//
//  Created by Grzegorz Biegaj on 14.06.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import Foundation

class DateTimeController {

    let dateTimeFormatter = DateFormatter()

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

    private func getTimeString(timestamp: Date) -> String {

        dateTimeFormatter.timeStyle = .none
        dateTimeFormatter.timeStyle = .short
        return dateTimeFormatter.string(from: timestamp)
    }

    private func getDateString(timestamp: Date) -> String {

        dateTimeFormatter.dateFormat = "d MMM"
        return dateTimeFormatter.string(from: timestamp)
    }

}
