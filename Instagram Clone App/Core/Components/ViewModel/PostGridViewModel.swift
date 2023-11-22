//
//  PostGridViewModelk.swift
//  Instagram Clone App
//
//  Created by Ikbal Demirdoven on 2023-11-21.
//

import Foundation

class PostGridViewModel : ObservableObject {
    private let user : User
    @Published var posts = [Post]()
    
    init(user: User) {
        self.user = user
        Task { try await fetchUserPost() }
    }
    
    @MainActor
    func fetchUserPost() async throws {
        self.posts = try await PostService.fetchUserPost(uid: user.id)
        for i in 0 ..< posts.count {
            posts[i].user = self.user
        }
    }
}
