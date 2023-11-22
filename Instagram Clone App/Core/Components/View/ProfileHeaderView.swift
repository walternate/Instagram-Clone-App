//
//  ProfileHeaderView.swift
//  Instagram Clone App
//
//  Created by Ikbal Demirdoven on 2023-11-11.
//

import SwiftUI

struct ProfileHeaderView: View {
    let user : User
    @State private var showEditProfile = false
    var body: some View {
        VStack (spacing: 10) {
            HStack {
                //pic and stats
                CircularProfileImageView(user: user, size: .large)
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
                if let fullname = user.fullname {
                    Text(fullname)
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                if let bio = user.bio {
                    Text(bio)
                        .font(.footnote)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 30)
            
            //action button
            Button {
                if user.isCurrentUser {
                    print("Edit Profile")
                    showEditProfile.toggle()
                } else {
                    print("Follow")
                }
            } label: {
                Text(user.isCurrentUser ? "Edit Profile" : "Follow")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 340, height: 32)
                    .background(user.isCurrentUser ? .white : .blue)
                    .foregroundColor(user.isCurrentUser ? .black : .white)
                    .cornerRadius(6)
                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(user.isCurrentUser ? Color.gray : .clear, lineWidth: 1))
            }
            Divider()
        }
        .fullScreenCover(isPresented: $showEditProfile) {
            EditProfileView(user: user)
        }
    }
}

#Preview {
    ProfileHeaderView(user: User.MOCK_USERS[0])
}
