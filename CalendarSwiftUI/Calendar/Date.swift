//
//  Date.swift
//  CalendarSwiftUI
//
//  Created by Francesco Palumbo on 07/04/2020.
//  Copyright © 2020 Francesco Palumbo. All rights reserved.
//

import Foundation

extension Date {
    
    func isToday() -> Bool {
        return isSameDay(date: Date())
    }
    
    func isFuture() -> Bool {
        return self > Date()
    }
    
    func isSameDay(date:Date,in calendar : Calendar = .current) -> Bool {
        return calendar.isDate(date, inSameDayAs: self)
    }
    
    func addDay(by : Int ,in calendar : Calendar = .current) -> Date {
        return calendar.date(byAdding: .day, value: by, to: self)!
    }
    
    func addMonth(by : Int ,in calendar : Calendar = .current) -> Date {
        return calendar.date(byAdding: .month, value: by, to: self)!
    }
    
    func dayDiff(in calendar : Calendar = .current,to:Date) -> Int {
        return calendar.dateComponents([.day], from: self, to: to).day!
    }
    
    func monthDiff(in calendar : Calendar = .current,to:Date) -> Int {
        return calendar.dateComponents([.month], from: self, to: to).month!
    }
    
    func numberOfDays(in calendar : Calendar = .current) -> Int {
        return calendar.range(of: .day, in: .month, for: self)!.count
    }
    
    func allDays(in calendar : Calendar = .current) -> [Date] {
        var dateComponents = DateComponents()
        var dates : [Date] = []
        for index in 0..<numberOfDays(in: calendar) {
            dateComponents.setValue(index, for: .day)
            let date = calendar.date(byAdding: dateComponents, to: firstDay()!)!
            dates.append(date)
        }
        return dates
    }
    
    func date(at index : Int) -> Date {
        let days = allDays()
        if days.count > index {
            return days[index]
        }
        assert(false ,"index")
    }
    
    func firstDay(in calendar : Calendar = .current) -> Date? {
        if let interval = calendar.dateInterval(of: .month, for: self) {
            return interval.start
        }
        return nil
    }
    
    func firstDayOfWeek(in calendar : Calendar = .current) -> Int {
        let first = firstDay(in: calendar)!
        let components = calendar.dateComponents([.weekday], from: first)
        return components.weekday!
    }
    
    func lastDay(in calendar : Calendar = .current) -> Date? {
        if let interval = calendar.dateInterval(of: .month, for: self) {
            return interval.end
        }
        return nil
    }
    
    func dateComponents(in calendar : Calendar = .current) -> DateComponents {
        let components = calendar.dateComponents([.year,.month,.day], from: self)
        return components
    }
    
    func toLocalTime() -> Date {
        let timezone    = TimeZone.current
        let seconds     = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
}
