//
//  ProfileHeaderView.swift
//  Instagram Clone App
//
//  Created by Ikbal Demirdoven on 2023-11-11.
//

import SwiftUI

struct ProfileHeaderView: View {
    @State private var showEditProfile = false
    @ObservedObject var viewModel : ProfileViewModel
    init(user: User) {
        self.viewModel = ProfileViewModel(user: user)
    }
    private var user : User {
        return viewModel.user
    }
    private var isFollowed : Bool {
        return user.isFollowed ?? false
    }
    private var buttonTitle : String {
        if user.isCurrentUser {
            return "Edit Profile"
        } else {
            return isFollowed ? "Following" : "Follow"
        }
    }
    private var buttonBackgroundColor : Color {
        if user.isCurrentUser || isFollowed {
            return .white
        } else {
            return .blue
        }
    }
    private var buttonForegroundColor : Color {
        if user.isCurrentUser || isFollowed {
            return .black
        } else {
            return .white
        }
    }
    private var overlayColor : Color {
        if user.isCurrentUser || isFollowed {
            return .gray
        } else {
            return .clear
        }
    }
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
                    handleFollowTapped()
                }
            } label: {
                Text(buttonTitle)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 340, height: 32)
                    .background(buttonBackgroundColor)
                    .foregroundColor(buttonForegroundColor)
                    .cornerRadius(6)
                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(overlayColor, lineWidth: 1))
            }
            Divider()
        }
        .fullScreenCover(isPresented: $showEditProfile) {
            EditProfileView(user: user)
        }
    }
    func handleFollowTapped() {
        if isFollowed {
            viewModel.unfollow()
        } else {
            viewModel.follow()
        }
    }
}

#Preview {
    ProfileHeaderView(user: User.MOCK_USERS[0])
}
