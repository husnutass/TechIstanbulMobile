//
//  User.swift
//  UserList
//
//  Created by Hüsnü Taş on 21.01.2024.
//

import Foundation

struct User: Codable, Identifiable {
    var id: String
    var name: String
    var bio: String
    var avatarUrl: String
    var isChecked: Bool
    
    static func getEmptyUser() -> User {
        User(id: UUID().uuidString, name: "", bio: "", avatarUrl: "", isChecked: false)
    }
}
