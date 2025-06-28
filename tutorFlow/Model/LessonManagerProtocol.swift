//
//  LessonServiceProtocol.swift
//  tutorFlow
//
//  Created by Elina Kanzafarova on 26.06.2025.
//

import Foundation

protocol LessonManagerProtocol {
    func getAllLessons() -> [Lesson]
    func addLesson(with lessonData: LessonData)
    func updateLesson(oldLesson: Lesson, with newLessonData: LessonData)
    func deleteLesson(_ lesson: Lesson)
    func getLesson(at startDate: Date) -> Lesson?
}
