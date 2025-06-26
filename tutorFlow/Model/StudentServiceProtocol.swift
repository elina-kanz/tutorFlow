//
//  StudentServiceProtocol.swift
//  tutorFlow
//
//  Created by Elina Kanzafarova on 26.06.2025.
//
protocol StudentServiceProtocol {
    func getAllStudents() -> [Student]
    func addStudent(_ StudentData: StudentData)
    func updateStudent(_ lessonData: StudentData)
    func deleteStudent(id: String)
    func searchStudents()
}
