//
//  RegistrationVievModel.swift
//  Instagram Clone App
//
//  Created by Ikbal Demirdoven on 2023-11-12.
//

import Foundation

class RegistrationViewModel : ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var email = ""
    
    func createUser() async throws {
        try await AuthService.shared.createUser(email: email, password: password, username: username)
        username = ""
        password = ""
        email = ""
    }
}
