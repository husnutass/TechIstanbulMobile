//
//  FirestoreManager.swift
//  UserList
//
//  Created by Hüsnü Taş on 21.01.2024.
//

import Foundation
import FirebaseFirestore

class FirestoreManager {
    
    static let shared = FirestoreManager()
    
    private let db = Firestore.firestore()
    
    private init() {}
    
    func getUsers() async -> [User] {
        var users: [User] = []
        
        do {
            let querySnapshot = try await db.collection(FirestoreCollection.users.rawValue).getDocuments()
            for document in querySnapshot.documents {
                
                print("\(document.documentID) => \(document.data())")
                let user = try document.data(as: User.self)
                users.append(user)
            }
        } catch {
            print("Error getting documents: \(error.localizedDescription)")
        }
        
        return users
    }
    
    func getUser(with id: String) async -> User? {
        let docRef = db.collection(FirestoreCollection.users.rawValue).document(id)
        
        do {
            let user = try await docRef.getDocument(as: User.self)
            print("City: \(user)")
            return user
        } catch {
            print("Error decoding city: \(error.localizedDescription)")
            return nil
        }
    }
    
    func addUser(_ user: User) async {
        do {
            try await db.collection(FirestoreCollection.users.rawValue).document(user.id).setData([
                "name": user.name,
                "avatarUrl": user.avatarUrl,
                "bio": user.bio,
                "id": user.id,
                "isChecked": user.isChecked
            ])
            print("Document successfully written!")
        } catch {
            print("Error writing document: \(error.localizedDescription)")
        }
    }
    
}

enum FirestoreCollection: String {
    case users
}
