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
        user.isFollowed = true
    }
    
    func unfollow() {
        user.isFollowed = false
    }
    
    func checkIfUserIsFollowed() {
        
    }
}
