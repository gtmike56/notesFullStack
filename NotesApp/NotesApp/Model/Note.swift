//
//  Note.swift
//  NotesApp
//
//  Created by Mikhail Udotov on 22.03.2021.
//

import Foundation

struct Note: Codable, Identifiable {
    
    var id: String
    var date: String
    var note: String
    
    enum CodingKeys: String, CodingKey{
        case id = "_id"
        case date = "date"
        case note = "note"
    }
}
