//
//  Constants.swift
//  Instagram Clone App
//
//  Created by Ikbal Demirdoven on 2023-11-26.
//

import Firebase

struct FirebaseConstants {
    static let Root = Firestore.firestore()
    
    static let Users = Root.collection("users")
    
    static let Posts = Root.collection("posts")
    
    static let FollowingCollection = Root.collection("following")
    static let FollowersCollection = Root.collection("followers")
}
