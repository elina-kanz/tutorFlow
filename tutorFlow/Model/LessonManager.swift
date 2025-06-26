//
//  LessonManager.swift
//  tutorFlow
//
//  Created by Elina Kanzafarova on 14.06.2025.
//

import Foundation

struct Lesson {
    let id: UUID
    var startDate: Date
    var duration: Int
    var title: String
    var students: [Student] = []
}

class LessonManager {
    
    static let shared = LessonManager()
    
    private var students: [Student] = []
    private(set) var lessons: [Lesson]  = []
    
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
    
    func updateLesson(_ lesson: Lesson, with newLessonData: LessonData) {
        guard let index = lessons.firstIndex(where: { $0.id == lesson.id}) else { return }
        lessons[index].title = newLessonData.title
        lessons[index].startDate = newLessonData.startDate
        lessons[index].students = newLessonData.students
        lessons[index].duration = newLessonData.duration
     }
    
    func deleteLesson(_ lesson: Lesson) {
        guard let index = lessons.firstIndex(where: { $0.id == lesson.id}) else { return }
        lessons.remove(at: index)
    }
    
    func lesson(at date: Date) -> Lesson? {
        let calendar = Calendar.current
        
        return lessons.first { lesson in
            calendar.isDate(lesson.startDate, equalTo: date, toGranularity: .hour)
        }
    }


    struct LessonData {
        let startDate: Date
        let duration: Int
        let title: String
        let students: [Student]
    }
}
