//
//  LoginViewModel.swift
//  Instagram Clone App
//
//  Created by Ikbal Demirdoven on 2023-11-12.
//

import Foundation

class LoginViewModel : ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async throws {
        try await AuthService.shared.login(email: email, password: password)
    }

}
