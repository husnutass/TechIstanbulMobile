//
//  UserService.swift
//  UserList
//
//  Created by Hüsnü Taş on 28.01.2024.
//

import Foundation

final class UserService: BaseService {
    
    func getUsers() async throws -> Users {
        do {
            return try await apiManager.fetchData(endpoint: .users, httpMethod: .get)
        } catch {
            throw error
        }
    }
    
    func deleteUser(id: String) async throws -> String {
        do {
            return try await apiManager.fetchData(endpoint: .users, httpMethod: .delete, path: id)
        } catch {
            throw error
        }
    }
    
}
