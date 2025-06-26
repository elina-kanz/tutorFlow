//
//  Student.swift
//  tutorFlow
//
//  Created by Elina Kanzafarova on 14.06.2025.
//

import Foundation

struct Student {
    let id: UUID
    var name: String? = nil
    var surname: String? = nil
    var parents: [String?] = []
    var phoneNumber: String? = nil
}

class StudentManager {
        static let shared = StudentManager()
        
        private var students: [Student] = []
        private(set) var lessons: [Lesson]  = []
        
        func addStudent(_ studentData: StudentData) {
            let newStudent = Student(
                id: UUID(),
                name: studentData.name,
                surname: studentData.surname,
                parents: studentData.parents,
                phoneNumber: studentData.phoneNumber
            )
            students.append(newStudent)
        }
        
        func updateStudent(_ student: Student, with newLessonData: StudentData) {
            guard let index = students.firstIndex(where: { $0.id == student.id}) else { return }
            students[index].name = newLessonData.name
            students[index].surname = newLessonData.surname
            students[index].parents = newLessonData.parents
            students[index].phoneNumber = newLessonData.phoneNumber
         }
        
        func deleteStudent(_ student: Student) {
            guard let index = students.firstIndex(where: { $0.id == student.id}) else { return }
            students.remove(at: index)
        }
    
    func getAllStudents() -> [Student] {
        return students
    }

        struct StudentData {
            var name: String? = nil
            var surname: String? = nil
            var parents: [String?] = []
            var phoneNumber: String? = nil
        }
    }

