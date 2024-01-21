//
//  NewUserViewModel.swift
//  UserList
//
//  Created by Hüsnü Taş on 21.01.2024.
//

import Foundation

final class NewUserViewModel: ObservableObject {
    
    @Published var user = User.getEmptyUser()
    
    func addUser() async {
        await FirestoreManager.shared.addUser(user)
    }
    
}
