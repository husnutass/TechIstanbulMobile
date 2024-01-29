//
//  HomeViewModel.swift
//  UserList
//
//  Created by Hüsnü Taş on 21.01.2024.
//

import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    
    private let service = UserService()
    
    @Published var users: Users = []
    @Published var isErrorShowing = false
    var errorMessage = ""
    
    
    func getUsers() async {
        do {
            self.users = try await service.getUsers()
        } catch {
            self.handleError(error: error)
        }
    }
    
    func deleteUser(id: String) async {
        do {
            let _ = try await service.deleteUser(id: id)
        } catch {
            self.handleError(error: error)
        }
    }
    
    func handleError(error: Error) {
        errorMessage = error.localizedDescription
        isErrorShowing = true
    }
    
}

extension HomeViewModel {
    //    func getUsers() async {
    //        users = await FirestoreManager.shared.getUsers()
    //    }
    
    func getUsersOld() {
        APIManager().getUsers { [weak self] result in
//            print("Users: \(users)")
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self?.users = success
                case .failure(let failure):
                    self?.errorMessage = failure.localizedDescription
                    self?.isErrorShowing = true
                }
            }
        }
    }
}
