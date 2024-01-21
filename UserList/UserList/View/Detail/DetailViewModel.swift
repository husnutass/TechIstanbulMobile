//
//  DetailViewModel.swift
//  UserList
//
//  Created by Hüsnü Taş on 21.01.2024.
//

import Foundation

@MainActor
final class DetailViewModel: ObservableObject {
    
    @Published var user: User?
    
    func getUser(with id: String) async {
        user = await FirestoreManager.shared.getUser(with: id)
    }
    
    func updateUser() async {
        guard let user else { return }
        await FirestoreManager.shared.addUser(user)
    }
    
}
