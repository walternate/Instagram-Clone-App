//
//  CurrentUserProfileView.swift
//  Instagram Clone App
//
//  Created by Ikbal Demirdoven on 2023-11-11.
//

import SwiftUI

struct CurrentUserProfileView: View {
    let user : User
    var body: some View {
        NavigationStack {
            ScrollView {
                //header
                VStack(spacing: 10) {
                    ProfileHeaderView(user: user)
                }
                //post grid view
                PostGridView(user: user)
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
