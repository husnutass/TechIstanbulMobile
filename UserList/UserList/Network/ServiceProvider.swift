//
//  ServiceProvider.swift
//  UserList
//
//  Created by Hüsnü Taş on 28.01.2024.
//

import Foundation

final class ServiceProvider {
    
    private let baseUrl = "https://userlistapi.netlify.app/api/"
    
    func getFullUrl(endpoint: Endpoint) -> URL? {
        let urlString = baseUrl + endpoint.rawValue
        
        let url = URL(string: urlString)
        
        return url
    }
    
}
