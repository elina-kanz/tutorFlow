//
//  DateManager.swift
//  tutorFlow
//
//  Created by Elina Kanzafarova on 27.06.2025.
//


import Foundation

protocol DateManagerProtocol {
    func getCurrentStartOfWeek() -> Date
    func getStartOfWeek(date: Date) -> Date
    func getNextWeekStart(from date: Date) -> Date
    func getPreviousWeekStart(from date: Date) -> Date
    func getWeekDates(from startDate: Date) -> [Date]
    func getDate(on selectedDay: Date, at selectedHour: Int) -> Date
    func isToday(_ date: Date) -> Bool
}

struct DateManager: DateManagerProtocol {
    
    private let calendar: Calendar
    
    init(calendar: Calendar = .current) {
        self.calendar = calendar
    }
    
    func getCurrentStartOfWeek() -> Date {
        getStartOfWeek(date: Date())
    }
    
    func getStartOfWeek(date: Date) -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)
        return calendar.date(from: components)!
    }
    
    func getNextWeekStart(from date: Date) -> Date {
        return Calendar.current.date(byAdding: .weekOfYear, value: 1, to: date)!
    }
    
    func getPreviousWeekStart(from date: Date) -> Date {
        return Calendar.current.date(byAdding: .weekOfYear, value: -1, to: date)!
    }
    
    func getWeekDates(from startDate: Date) -> [Date] {
        return (0..<7).map {
            Calendar.current.date(byAdding: .day, value: $0, to: startDate)!
        }
    }
    
    func getDate(on selectedDay: Date, at selectedHour: Int) -> Date {
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: selectedDay)
        dateComponents.hour = selectedHour
        dateComponents.minute = 0
        return calendar.date(from: dateComponents)!
    }
    
    func isToday(_ date: Date) -> Bool {
        return Calendar.current.isDateInToday(date)
    }
}
