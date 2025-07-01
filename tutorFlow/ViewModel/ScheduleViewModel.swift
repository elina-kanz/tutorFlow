//
//  ScheduleViewModel.swift
//  tutorFlow
//
//  Created by Elina Kanzafarova on 01.07.2025.
//

import Foundation
final class ScheduleViewModel {
    
    // MARK: - Dependencies
    let lessonManager: LessonManagerProtocol
    private let studentManager: StudentManagerProtocol
    private let dateManager: DateManagerProtocol
    private let dateFormatter: DateFormatterServiceProtocol
    
    // MARK: - State
    private(set) var currentWeekStartDate: Date {
        didSet {
            daysOfWeek = dateManager.getWeekDates(from: currentWeekStartDate)
            onDataChanged?()
        }
    }
    
    private(set) var daysOfWeek: [Date]
    
    // MARK: - Callbacks
    
    var onDataChanged: (() -> Void)?
    
    // MARK: - Init
    
    init(
        lessonManager: LessonManagerProtocol = LessonManager.shared,
        studentManager: StudentManagerProtocol = StudentManager.shared,
        dateManager: DateManagerProtocol = DateManager(),
        dateFormatter: DateFormatterServiceProtocol = DateFormatterService()
    ) {
        self.lessonManager = lessonManager
        self.studentManager = studentManager
        self.dateManager = dateManager
        self.dateFormatter = dateFormatter
        
        self.currentWeekStartDate = dateManager.getCurrentStartOfWeek()
        self.daysOfWeek = dateManager.getWeekDates(from: currentWeekStartDate)
    }
    
    // MARK: - Outputs
    
    var monthYearText: String {
        dateFormatter.monthYearString(from: currentWeekStartDate)
    }
    
    func dateFor(section: Int, item: Int) -> Date {
        let day = daysOfWeek[item]
        return dateManager.getDate(on: day, at: section)
    }
    
    func getLesson(at date: Date) -> Lesson? {
        return lessonManager.getLesson(at: date)
    }
    
    func dayWeekString(from date: Date) -> String {
        dateFormatter.dayWeekString(from: date)
    }
    
    func isToday(_ date: Date) -> Bool {
        dateManager.isToday(date)
    }
    
    func dayMonthString(from date: Date) -> String {
        dateFormatter.dateString(from: date)
    }
    func nextWeek() {
        currentWeekStartDate = dateManager.getNextWeekStart(from: currentWeekStartDate)
    }
    
    func previousWeek() {
        currentWeekStartDate = dateManager.getPreviousWeekStart(from: currentWeekStartDate)
    }
}
