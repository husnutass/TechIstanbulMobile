//
//  APIManager.swift
//  UserList
//
//  Created by Hüsnü Taş on 28.01.2024.
//

import Foundation

final class APIManager {
    
    private let serviceProvider = ServiceProvider()
    
    func fetchData<T: Decodable>(endpoint: Endpoint, httpMethod: HttpMethod, body: Encodable? = nil, path: String? = nil) async throws -> T {
        var url = serviceProvider.getFullUrl(endpoint: endpoint)
        
        if let path {
            url?.append(path: path)
        }
        
        guard let url else { throw CustomError.invalidUrl }
        
        print("URL: \(url.description)")
                
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = httpMethod.rawValue
        
        print("Request: \(urlRequest.description)")
        
        if let body {
            urlRequest.httpBody = try JSONEncoder().encode(body)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            
            let stringData = String(data: data, encoding: .utf8)
            print("data: \(stringData)")
            
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            print(error.localizedDescription)
            throw CustomError.other(error)
        }
    }
    
}





extension APIManager {
    func getUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        let urlString = "https://user-list-api.adaptable.app/users"
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)
        
        print("start")
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error {
                print(error.localizedDescription)
                completion(.failure(error))
            }
            
            guard let data else { return }
            //                let stringData = String(data: data, encoding: .utf8)
            //                print("data: \(stringData)")
            
            do {
                let decodedData = try JSONDecoder().decode([User].self, from: data)
//                print("data: \(decodedData)")
                completion(.success(decodedData))
            } catch {
                print(error.localizedDescription)
                completion(.failure(error))
            }
            
//            print("response: \(response)")
//            print("error: \(error)")
        }.resume()
        print("end")
    }
}
