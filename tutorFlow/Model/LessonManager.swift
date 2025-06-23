//
//  LessonManager.swift
//  tutorFlow
//
//  Created by Elina Kanzafarova on 14.06.2025.
//

import Foundation

struct Lesson {
    var id: UUID
    var startDate: Date
    let duration: TimeInterval
    var title: String
    var students: [Student?] = []
}

class LessonManager {
    
    static let shared = LessonManager()
    
    private var scheduleData: [Date: [Lesson]] = [:]
    private var students: [Student] = []
    var lessons: [Lesson]  = []
    
    func addLesson(_ lessondata: LessonData) {
        let newId = UUID()
        let newLesson = Lesson(
            id: newId,
            startDate: lessondata.startDate,
            duration: lessondata.duration,
            title: lessondata.title,
            students: lessondata.students
        )
        
        lessons.append(newLesson)
    }
    
    func lesson(at date: Date) -> Lesson? {
        let calendar = Calendar.current
        
        return lessons.first { lesson in
            calendar.isDate(lesson.startDate, equalTo: date, toGranularity: .hour)
        }
    }


    struct LessonData {
        let startDate: Date
        let duration: TimeInterval
        let title: String
        let students: [Student]
    }
}
