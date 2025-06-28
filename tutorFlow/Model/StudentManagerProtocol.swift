//
//  StudentServiceProtocol.swift
//  tutorFlow
//
//  Created by Elina Kanzafarova on 26.06.2025.
//
protocol StudentManagerProtocol {
    func getAllStudents() -> [Student]
    func addStudent(_ StudentData: StudentData)
    func updateStudent(_ student: Student, with newLessonData: StudentData)
    func deleteStudent(_ student: Student)
    func searchStudents(with searchText: String) -> [Student]
}
