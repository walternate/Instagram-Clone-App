//
//  ProfileView.swift
//  Instagram Clone App
//
//  Created by Ikbal Demirdoven on 2023-11-08.
//

import SwiftUI

struct ProfileView: View {
    let user : User
    
    private var posts : [Post] {
        return Post.MOCK_POSTS.filter({ $0.user?.username == user.username })
    }
    var body: some View {
        ScrollView {
            //header
            ProfileHeaderView(user: user)
            //post grid view
            PostGridView(posts: posts)
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    ProfileView(user: User.MOCK_USERS[0])
}
