//
//  CurrentUserProfileView.swift
//  Instagram Clone App
//
//  Created by Ikbal Demirdoven on 2023-11-11.
//

import SwiftUI

struct CurrentUserProfileView: View {
    let user : User
    private var posts : [Post] {
        return Post.MOCK_POSTS.filter({ $0.user?.username == user.username })
    }
    var body: some View {
        NavigationStack {
            ScrollView {
                //header
                VStack(spacing: 10) {
                    HStack {
                        //pic and stats
                        Image("blackpanther")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                        Spacer()
                        HStack(spacing: 8) {
                            UserStatView(value: 3, title: "Posts")
                            UserStatView(value: 4, title: "Followers")
                            UserStatView(value: 5, title: "Following")
                        }
                    }
                    .padding(.horizontal, 30)
                    //name and bio
                    VStack(alignment: .leading, spacing: 4) {
                        Text(user.username)
                            .font(.footnote)
                            .fontWeight(.semibold)
                        Text("Wakanda Forever!")
                            .font(.footnote)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 30)
                    
                    //action button
                    Button {
                        
                    } label: {
                        Text("Edit Profile")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .frame(width: 340, height: 32)
                            .foregroundColor(.black)
                            .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.gray, lineWidth: 1))
                    }
                    Divider()
                }
                //post grid view
                PostGridView(posts: posts)
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        AuthService.shared.signOut()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundStyle(.black)
                    }
                }
            }
        }
    }
} 

#Preview {
    CurrentUserProfileView(user: User.MOCK_USERS[0])
}
