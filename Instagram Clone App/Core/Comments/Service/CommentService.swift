//
//  CommentService.swift
//  Instagram Clone App
//
//  Created by Ikbal Demirdoven on 2023-11-24.
//

import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct CommentService {
    let postId : String
    func uploadComment(_ comment : Comment) async throws {
        guard let commentData = try? Firestore.Encoder().encode(comment) else { return }
        try await
            FirebaseConstants.Posts
            .document(postId)
            .collection("post-comments")
            .addDocument(data: commentData)
    }
    func fetchComment() async throws -> [Comment] {
        let snapshot = try await FirebaseConstants.Posts.document(postId).collection("post-comments").order(by: "timestamp", descending: true).getDocuments()
        return snapshot.documents.compactMap( { try? $0.data(as: Comment.self )} )
    }
}
