//
//  NoteModel.swift
//  Notes
//
//  Created by Alex Luna on 30/04/2021.
//

import Foundation

struct Note: Codable {
    var id: UUID
    var date: Date
    var content: String
    var title: String

    init() {
        id = UUID()
        date = Date()
        content = ""
        title = ""
    }
}
