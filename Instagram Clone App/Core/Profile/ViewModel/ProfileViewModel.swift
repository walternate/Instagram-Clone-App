//
//  ProfileViewModel.swift
//  Instagram Clone App
//
//  Created by Ikbal Demirdoven on 2023-11-26.
//

import Foundation

class ProfileViewModel : ObservableObject {
    @Published var user : User
    init(user: User) {
        self.user = user
    }
}

// following function
extension ProfileViewModel {
    func follow() {
        Task {
            try await UserService.follow(uid: user.id)
            user.isFollowed = true
        }
    }
    
    func unfollow() {
        Task {
            try await UserService.unfollow(uid: user.id)
            user.isFollowed = false
        }
    }
    
    func checkIfUserIsFollowed() {
        
    }
}
