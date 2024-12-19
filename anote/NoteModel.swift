//
//  Note.swift
//  anote
//
//  Created by Alan Zeng on 2024/12/19.
//

//import Foundation
//
//struct Note: Identifiable, Codable {
//    var id = UUID()
//    var title: String
//    var content: String
//    var timestamp: Date
//}


//import Foundation
//
//struct Note: Identifiable {
//    let id: UUID
//    var title: String
//    var content: String
//
//    var preview: String {
//        content.split(separator: "\n").first.map(String.init) ?? ""
//    }
//}

import Foundation

struct Note: Identifiable, Codable {
    let id: UUID
    var title: String
    var content: String
    var tags: [String] 
    var preview: String {
        content.split(separator: "\n").first.map(String.init) ?? ""
    }
}
