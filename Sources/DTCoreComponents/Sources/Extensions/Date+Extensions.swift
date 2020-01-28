//
//  Date+Extensions.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

public extension Date {

    /// Returns a Date with the specified amount of components added to the one it is called with
    func add(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date {
        let components = DateComponents(year: years, month: months, day: days, hour: hours, minute: minutes, second: seconds)
        return Calendar.current.date(byAdding: components, to: self) ?? Date()
    }
    
    /// Returns a Date with the specified amount of components subtracted from the one it is called with
    func subtract(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date {
        return add(years: -years, months: -months, days: -days, hours: -hours, minutes: -minutes, seconds: -seconds)
    }
    
    func weekdayDayMonthLongString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE d MMMM"
        return dateFormatter.string(from: self)
    }

}
