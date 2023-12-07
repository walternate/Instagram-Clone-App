//
//  ProfileViewModel.swift
//  Instagram Clone App
//
//  Created by Ikbal Demirdoven on 2023-11-26.
//

import Foundation

@MainActor
class ProfileViewModel : ObservableObject {
    @Published var user : User
    init(user: User) {
        self.user = user
        checkIfUserIsFollowed()
        fetchUserStats()
    }
    func fetchUserStats() {
        Task {
            self.user.stats = try await UserService.fetchUserStat(uid: user.id)
        }
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
        Task { self.user.isFollowed = try await UserService.checkIfUserFollowed(uid: user.id )}
    }
}
