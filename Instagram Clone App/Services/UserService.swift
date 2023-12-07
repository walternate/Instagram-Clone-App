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

// Following Part

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
        guard let currentUid = Auth.auth().currentUser?.uid else { return false }
        let snapshot = try await FirebaseConstants
            .FollowingCollection
            .document(currentUid)
            .collection("user-following")
            .document(uid)
            .getDocument()
        return snapshot.exists
    }
}

// Stats Part
extension UserService {
    static func fetchUserStat(uid : String) async throws -> UserStats {
        async let followingSnapshot = try await FirebaseConstants
            .FollowingCollection
            .document(uid)
            .collection("user-following")
            .getDocuments()
        let followingCount = try await followingSnapshot.count
        
        async let followersSnapshot = try await FirebaseConstants
            .FollowersCollection
            .document(uid)
            .collection("user-followers")
            .getDocuments()
        let followersCount = try await followersSnapshot.count
        
        async let postsSnapshot = try await FirebaseConstants
            .Posts
            .whereField("ownerUid", isEqualTo: uid)
            .getDocuments()
        let postsCount = try await postsSnapshot.count
        
        print("Debug stats called...")
        
        return .init(followingCount: followingCount, followersCount: followersCount, postsCount: postsCount)
    }
}
