//
//  UserService.swift
//  Instagram Clone App
//
//  Created by Ikbal Demirdoven on 2023-11-13.
//

import Foundation
import Firebase

class UserService {
    @Published var currentUser : User?
    static let shared = UserService()
    
    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        self.currentUser = try await FirebaseConstants.Users.document(uid).getDocument(as: User.self)
    }
    
    static  func fetchUser(uid: String) async throws -> User {
        let snapshot = try await FirebaseConstants.Users.document(uid).getDocument()
        return try snapshot.data(as: User.self)
    }
    
    
    @MainActor
    static func fetchAllUsers() async throws -> [User] {
        let snapshot = try await FirebaseConstants.Users.getDocuments()
        return snapshot.documents.compactMap( { try? $0.data(as: User.self) })
    }
}

extension UserService {
    static func follow(uid : String) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        async let _ = try await FirebaseConstants
            .FollowingCollection
            .document(currentUid)
            .collection("user-following")
            .document(uid)
            .setData([:])
        
        async let _ = try await FirebaseConstants
            .FollowersCollection
            .document(uid)
            .collection("user-followers")
            .document(currentUid)
            .setData([:])
    }
    
    static func unfollow(uid : String) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        async let _ = try await FirebaseConstants
            .FollowingCollection
            .document(currentUid)
            .collection("user-following")
            .document(uid)
            .delete()
        
        async let _ = try await FirebaseConstants
            .FollowersCollection
            .document(uid)
            .collection("user-followers")
            .document(currentUid)
            .delete()
    }
    
    static func checkIfUserFollowed(uid : String) async throws -> Bool {
        return false
    }
}
