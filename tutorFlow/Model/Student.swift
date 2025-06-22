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
