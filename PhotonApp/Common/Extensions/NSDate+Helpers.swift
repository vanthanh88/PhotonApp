//
//  NSDate+Helpers.swift
//  UlaaiApp
//
//  Created by Ulaai on 11/16/15.
//  Copyright © 2015 Ulaai. All rights reserved.
//

import Foundation

extension NSDate: Comparable {
    
    // MARK: Components
    private class func componentFlags() -> NSCalendarUnit { return [NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.WeekOfYear, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second, NSCalendarUnit.Weekday, NSCalendarUnit.WeekdayOrdinal, NSCalendarUnit.WeekOfYear] }
    
    private class func components(fromDate fromDate: NSDate) -> NSDateComponents! {
        return NSCalendar.currentCalendar().components(NSDate.componentFlags(), fromDate: fromDate)
    }
    
    private func components() -> NSDateComponents  {
        return NSDate.components(fromDate: self)!
    }
    
    
    /**
     Returns the year component.
     */
    func year() -> Int { return self.components().year  }
    /**
     Returns the month component.
     */
    func month() -> Int { return self.components().month }
    /**
     Returns the week of year component.
     */
    func week() -> Int { return self.components().weekOfYear }
    /**
     Returns the day component.
     */
    func day() -> Int { return self.components().day }
    /**
     Returns the hour component.
     */
    func hour() -> Int { return self.components().hour }
    /**
     Returns the minute component.
     */
    func minute() -> Int { return self.components().minute }
    /**
     Returns the seconds component.
     */
    func seconds() -> Int { return self.components().second }
    
    
    
    var calendar: NSCalendar {
        return NSCalendar(identifier: NSCalendarIdentifierGregorian)!
    }
    
    func after(value: Int, calendarUnit:NSCalendarUnit) -> NSDate{
        return calendar.dateByAddingUnit(calendarUnit, value: value, toDate: self, options: NSCalendarOptions(rawValue: 0))!
    }
    
    func minus(date: NSDate) -> NSDateComponents{
        return calendar.components(NSCalendarUnit.Minute, fromDate: self, toDate: date, options: NSCalendarOptions(rawValue: 0))
    }
    
    func equalsTo(date: NSDate) -> Bool {
        return self.compare(date) == NSComparisonResult.OrderedSame
    }
    
    func greaterThan(date: NSDate) -> Bool {
        return self.compare(date) == NSComparisonResult.OrderedDescending
    }
    
    func lessThan(date: NSDate) -> Bool {
        return self.compare(date) == NSComparisonResult.OrderedAscending
    }
    
    
    class func parse(dateString: String, format: String = "yyyy-MM-dd HH:mm:ss") -> NSDate{
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        return formatter.dateFromString(dateString)!
    }
    
    func toString(format: String = "yyyy-MM-dd HH:mm:ss") -> String{
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        return formatter.stringFromDate(self)
    }
}

public func <=(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs == rhs || lhs < rhs
}

public func >=(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs == rhs || lhs > rhs
}

public func >(lhs: NSDate, rhs: NSDate) -> Bool {
    let result = lhs.compare(rhs)
    return result == NSComparisonResult.OrderedDescending
}

/**
 This method is not required by the Comparable protocol but Xcode 6 beta 3
 would not compile without it.
 */
public func <(lhs: NSDate, rhs: NSDate) -> Bool {
    let result = lhs.compare(rhs)
    return result == NSComparisonResult.OrderedAscending
}

func ==(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.isEqualToDate(rhs)
}

/**
 Operators for incrementing dates.
 */

func +(date: NSDate, interval: NSTimeInterval) -> NSDate {
    return date.dateByAddingTimeInterval(interval)
}

func +=(inout date: NSDate, interval: NSTimeInterval) {
    date = date + interval
}

func -(date: NSDate, interval: NSTimeInterval) -> NSDate {
    return date.dateByAddingTimeInterval(-interval)
}

func -=(inout date: NSDate, interval: NSTimeInterval) {
    date = date - interval
}


extension NSTimeInterval {
    
    var days: Int        { return Int(self / (3600 * 24)) }
    var hours: Int       { return Int((Int(self) % (3600 * 24)) / (3600)) }
    var minutes: Int     { return Int((Int(self) % 3600) / 60) }
    var seconds: Int     { return Int(Int(self) % 60) }
//    var miliseconds: Int { return Int(self) } //if milisec
    
    public func toDate() -> NSDate {
        let date = NSDate(timeIntervalSince1970: self/1000)
        return date
    }
    
    public func toStringTime(format: String) -> String {
        let date = self.toDate()
        let formater = NSDateFormatter()
        formater.dateFormat = format
        let result = formater.stringFromDate(date)
        return result
    }
    
    
}

extension NSDate {
    public func toStringTime(format: String) -> String {
        let formater = NSDateFormatter()
        formater.dateFormat = format
        let result = formater.stringFromDate(self)
        return result
    }
    public func toTimeInterval() -> NSTimeInterval {
        return self.timeIntervalSince1970 * 1000
    }
}


