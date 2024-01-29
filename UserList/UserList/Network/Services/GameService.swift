//
//  GameService.swift
//  UserList
//
//  Created by Hüsnü Taş on 28.01.2024.
//

import Foundation

final class GameService: BaseService {
    
    @Published var game: User?
    
    func getGame() async {
        game = try? await apiManager.fetchData(endpoint: .user, httpMethod: .get)
    }
    
}
