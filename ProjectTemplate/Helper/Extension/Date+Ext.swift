//
//  Date+Ext.swift
//  ProjectTemplate
//
//  Created by Vikas Kumar on 18/01/24.
//

import Foundation

extension Date {

    // Convert local time to UTC (or GMT)
    func toGlobalTime() -> Date {
       return self.toTime(isGlobalOrLocal: true)
    }

    // Convert UTC (or GMT) to local time
    func toLocalTime() -> Date {
        return self.toTime(isGlobalOrLocal: false)
    }

    func toTime(isGlobalOrLocal: Bool) -> Date {
        let timezone = TimeZone.current
        let seconds = isGlobalOrLocal ? -TimeInterval(timezone.secondsFromGMT(for: self)) : TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }

    func removeTimeStamp() -> Date {
        let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self))
        return date ?? self
    }
    func weekOfYear() -> Int {
        let weekOfYear = Calendar.current.component(.weekOfYear, from: self)
        return weekOfYear
    }
    
    func getTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "UTC"
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: self)
    }

    func getDate(in timezone: TimeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = timezone
        return dateFormatter.string(from: self)
    }

    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var tommorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }

    public var dayofTheWeek: String {
        let dayNumber = Calendar.current.component(.weekday, from: self)
        // day number starts from 1 but array count from 0
        return daysOfTheWeek[dayNumber - 1]
    }

    var dayOfMonth: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: self)
    }

    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }

    var year: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: self)
    }

    var graphXAxisDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d"
        return dateFormatter.string(from: self)
    }

    var quarterDisplayStartDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        return dateFormatter.string(from: self)
    }
    
    var fullMonthDisplayDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        return dateFormatter.string(from: self)
    }
    
    var stringOnMMddyy: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd.yy"
        return dateFormatter.string(from: self).replacingOccurrences(of: ".", with: "/")
    }

    var stringOnMMddyyyy: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: self)
    }

    var quarterDisplayEndDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: self)
    }
    
    func totalNumberOfDays(endDate: Date) -> Int {
        Calendar.current.dateComponents([.day], from: self, to: endDate).day ?? 0
    }

    func totalNumberOfWeeks(endDate: Date) -> Int {
        let totalWeeks = Calendar.current.dateComponents([.weekOfMonth], from: self, to: endDate).weekOfMonth
        return totalWeeks ?? 0
    }

    func totalNumberOfMonths(endDate: Date) -> Int {
        let totalWeeks = Calendar.current.dateComponents([.month], from: self, to: endDate).month
        return totalWeeks ?? 0
    }

    var monthOfDateInInt: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        return dateFormatter.string(from: self)
    }

    internal var daysOfTheWeek: [String] {
        return  ["Su", "M", "Tu", "W", "Th", "F", "Sa"]
    }

    static func dates(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate

        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }

    func isBetweeen(date date1: Date, andDate date2: Date) -> Bool {
        return date1.dayBefore.compare(self) == self.compare(date2.tommorrow)
    }

    func adding(minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
    }

    func adding(hours: Int) -> Date {
        return Calendar.current.date(byAdding: .hour, value: hours, to: self)!
    }

    func adding(days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self)!
    }

    var string: String {
        "\(self)"
    }

    func formatted(with dateFormatter: DateFormatter) -> String {
        dateFormatter.string(from: self)
    }
}
