//
//  SearchViewModel.swift
//  Instagram Clone App
//
//  Created by Ikbal Demirdoven on 2023-11-13.
//

import Foundation

class SearchViewModel : ObservableObject {
    @Published var users = [User]()
    
    init() {
        Task { try await fetchAllUsers() }
    }
    
    @MainActor
    func fetchAllUsers() async throws {
        self.users = try await UserService.fetchAllUsers()
    }
}
