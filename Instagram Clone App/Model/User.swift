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
    
    var isCurrentUser : Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else { return false }
        return currentUid == id
    }
}

extension User {
    static var MOCK_USERS : [User]  = [
        .init(id: NSUUID().uuidString, email: "blackpanther@gmail.com", username: "blackpanther", profileImageURL: "blackpanther", fullname: "Chadwick Boseman", bio: "Wakanda Forever"),
        .init(id: NSUUID().uuidString, email: "batman@gmail.com", username: "batman", profileImageURL: "batman", fullname: "Bruce Wayne", bio: "Gotham"),
        .init(id: NSUUID().uuidString, email: "ironman@gmail.com", username: "ironman", profileImageURL: "ironman", fullname: "Tony Stark", bio: "Ironman"),
        .init(id: NSUUID().uuidString, email: "venom@gmail.com", username: "venom", profileImageURL: "venom", fullname: nil, bio: "Venom"),
        .init(id: NSUUID().uuidString, email: "aquaman@gmail.com", username: "aquaman", profileImageURL: "aquaman", fullname: "aquaman", bio: "Aquaman")
    ]
}
