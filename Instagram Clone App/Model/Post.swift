//
//  Post.swift
//  Instagram Clone App
//
//  Created by Ikbal Demirdoven on 2023-11-11.
//

import Foundation
import Firebase

struct Post : Hashable, Codable, Identifiable {
    let id : String
    let ownerUid : String
    let caption : String
    var likes : Int
    let imageURL : String
    let timeStamp : Timestamp
    var user : User?
    var didLike : Bool? = false
}

extension Post {
    static var post = "https://firebasestorage.googleapis.com:443/v0/b/instagramclone-c2e57.appspot.com/o/profile_image6C023825-F7F6-465E-AAF9-1F4B7F6F4891?alt=media&token=0b60363b-4d91-4faf-b797-fc49dc628cff"
    static var MOCK_POSTS : [Post] =
    [
        .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, caption: "Batman caption", likes: 123, imageURL: "batman", timeStamp: Timestamp(), user: User.MOCK_USERS[1]),
        .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, caption: "Blackpanther caption", likes: 234, imageURL: "blackpanther", timeStamp: Timestamp(), user: User.MOCK_USERS[0]),
        .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, caption: "Ironman caption", likes: 123, imageURL: "ironman", timeStamp: Timestamp(), user: User.MOCK_USERS[2]),
        .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, caption: "Venom caption", likes: 123, imageURL: "venom", timeStamp: Timestamp(), user: User.MOCK_USERS[3]),
        .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, caption: "Aquaman caption", likes: 123, imageURL: "aquaman", timeStamp: Timestamp(), user: User.MOCK_USERS[4]),
    ]
}
