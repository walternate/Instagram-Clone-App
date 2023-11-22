//
//  PostService.swift
//  Instagram Clone App
//
//  Created by Ikbal Demirdoven on 2023-11-21.
//

import Foundation
import Firebase

struct PostService {
    private static let postsCollection = Firestore.firestore().collection("posts")
    static func fetchAllPosts() async throws -> [Post] {
        let snapshot = try await postsCollection.getDocuments()
        var posts = try snapshot.documents.compactMap({ try $0.data(as: Post.self)})
        
        for i in 0..<posts.count {
            let post = posts[i]
            let ownerUid = post.ownerUid
            let postUser = try await UserService.fetchUser(uid: ownerUid)
            posts[i].user = postUser
        }
        return posts
    }
    static func fetchUserPost(uid : String) async throws -> [Post] {
        let snapshot = try await postsCollection.whereField("ownerUid", isEqualTo: uid).getDocuments()
        return try snapshot.documents.compactMap({ try $0.data(as: Post.self)})
    }
}


