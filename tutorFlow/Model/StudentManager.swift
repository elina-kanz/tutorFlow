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

struct StudentData {
    var name: String? = nil
    var surname: String? = nil
    var parents: [String?] = []
    var phoneNumber: String? = nil
}

class StudentManager: StudentManagerProtocol {
    static let shared = StudentManager()
    
    private(set) var lessons: [Lesson]  = []
    private var students: [Student] = []
    
    func addStudent(name: String, surname: String, parents: [String], phoneNumber: String) {
        let newStudent = Student(
            id: UUID(),
            name: name,
            surname: surname,
            parents: parents,
            phoneNumber: phoneNumber
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
    
    func searchStudents(with searchText: String) -> [Student] {
        students.filter {
            $0.name?.lowercased().contains(searchText) ?? false
        }
    }
    
    func getAllStudents() -> [Student] {
        return students
    }
}

private var masha = Student(
    id: UUID(),
    name: "Masha",
    surname: "I",
    parents: ["Dmitriy", "Elena"],
    phoneNumber: "80000000"
)

private var katya = Student(
    id: UUID(),
    name: "Katya",
    surname: "V",
    parents: ["Dmitriy", "Elena"],
    phoneNumber: "80000000"
)

private var sasha = Student(
    id: UUID(),
    name: "Sasha",
    surname: "V",
    parents: ["Dmitriy", "Elena"],
    phoneNumber: "80000000"
)
