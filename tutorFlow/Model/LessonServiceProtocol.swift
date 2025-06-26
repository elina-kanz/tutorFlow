//
//  LessonServiceProtocol.swift
//  tutorFlow
//
//  Created by Elina Kanzafarova on 26.06.2025.
//

protocol LessonServiceProtocol {
    func getAllLessons() -> [Lesson]
    func addLesson(_ lessonData: LessonData)
    func updateLesson(_ lessonData: LessonData)
    func deleteLesson(id: String)
}
