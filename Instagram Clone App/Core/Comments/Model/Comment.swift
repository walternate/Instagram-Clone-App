//
//  Model.swift
//  Instagram Clone App
//
//  Created by Ikbal Demirdoven on 2023-11-24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Comment : Identifiable, Codable {
    @DocumentID var commentId : String?
    var user : User?
    var id : String {
        return commentId ?? NSUUID().uuidString
    }
    let commentOwnerUid : String
    let commentText : String
    let postId : String
    let postOwnerUid : String
    let timestamp : Timestamp
}
