//
//  UserService.swift
//  Instagram Clone App
//
//  Created by Ikbal Demirdoven on 2023-11-13.
//

import Foundation
import Firebase

struct UserService {
    
    static  func fetchUser(uid: String) async throws -> User {
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        return try snapshot.data(as: User.self)
    }
    
    
    @MainActor
    static func fetchAllUsers() async throws -> [User] {
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        return snapshot.documents.compactMap( { try? $0.data(as: User.self) })
    }
}
