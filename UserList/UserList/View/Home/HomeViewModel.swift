//
//  HomeViewModel.swift
//  UserList
//
//  Created by Hüsnü Taş on 21.01.2024.
//

import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    
    @Published var users: [User] = []
    
    func getUsers() async {
        users = await FirestoreManager.shared.getUsers()
    }
    
}
