//
//  FeedViewModel.swift
//  Instagram Clone App
//
//  Created by Ikbal Demirdoven on 2023-11-21.
//

import Foundation
import Firebase

class FeedViewModel : ObservableObject {
    @Published var posts = [Post]()
    
    init() {
        Task { try await fetchPosts() }
    }
    @MainActor
    func fetchPosts() async throws {
        self.posts = try await PostService.fetchAllPosts()
    }
}
