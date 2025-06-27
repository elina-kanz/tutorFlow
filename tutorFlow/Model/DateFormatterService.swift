//
//  DateFormatterService.swift
//  tutorFlow
//
//  Created by Elina Kanzafarova on 27.06.2025.
//


import Foundation

struct DateFormatterService {
    
    static let shared = DateFormatterService()
    
    private let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }()
    
    private let monthYearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
    
    func dayWeekString(from date: Date) -> String {
        return dayFormatter.string(from: date)
    }
    
    func dateString(from date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    func monthYearString(from date: Date) -> String {
        return monthYearFormatter.string(from: date)
    }
}
