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

struct LessonData {
    let startDate: Date
    let duration: Int
    let title: String
    let students: [Student]
}

class LessonManager: LessonManagerProtocol {
    
    static let shared = LessonManager()
    
    private var students: [Student] = []
    private(set) var lessons: [Lesson]  = []
    

    
    func getAllLessons() -> [Lesson] {
        return lessons
    }
    
    func addLesson(with lessonData: LessonData) {
        let newId = UUID()
        let newLesson = Lesson(
            id: newId,
            startDate: lessonData.startDate,
            duration: lessonData.duration,
            title: lessonData.title,
            students: lessonData.students
        )
        
        lessons.append(newLesson)
    }
    
    func updateLesson(oldLesson: Lesson, with newLessonData: LessonData) {
        guard let index = lessons.firstIndex(where: { $0.id == oldLesson.id}) else { return }
        lessons[index].title = newLessonData.title
        lessons[index].startDate = newLessonData.startDate
        lessons[index].students = newLessonData.students
        lessons[index].duration = newLessonData.duration
     }
    
    func getLesson(at startDate: Date) -> Lesson? {
        return lessons.first(where: {$0.startDate == startDate})
    }
    
    func deleteLesson(_ lesson: Lesson) {
        guard let index = lessons.firstIndex(where: { $0.id == lesson.id}) else { return }
        lessons.remove(at: index)
    }
}

