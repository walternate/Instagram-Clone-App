//
//  User.swift
//  Instagram Clone App
//
//  Created by Ikbal Demirdoven on 2023-11-11.
//

import Foundation
import Firebase

struct User : Identifiable, Hashable, Codable {
    let id : String
    let email : String
    var username : String
    var profileImageURL : String?
    var fullname : String?
    var bio : String?
    var isFollowed : Bool? = false
    var stats : UserStats?
    var isCurrentUser : Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else { return false }
        return currentUid == id
    }
}

struct UserStats : Codable, Hashable {
    var followingCount : Int
    var followersCount : Int
    var postsCount : Int
}

extension User {
    static var MOCK_USERS : [User]  = [
        .init(id: NSUUID().uuidString, email: "blackpanther@gmail.com", username: "blackpanther", profileImageURL: nil, fullname: "Chadwick Boseman", bio: "Wakanda Forever"),
        .init(id: NSUUID().uuidString, email: "batman@gmail.com", username: "batman", profileImageURL: nil, fullname: "Bruce Wayne", bio: "Gotham"),
        .init(id: NSUUID().uuidString, email: "ironman@gmail.com", username: "ironman", profileImageURL: nil, fullname: "Tony Starrrk", bio: "Ironman"),
        .init(id: NSUUID().uuidString, email: "venom@gmail.com", username: "venom", profileImageURL: nil, fullname: nil, bio: "Venom"),
        .init(id: NSUUID().uuidString, email: "aquaman@gmail.com", username: "aquaman", profileImageURL: nil, fullname: "aquaman", bio: "Aquaman")
    ]
}
