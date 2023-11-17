//
//  AuthService.swift
//  Instagram Clone App
//
//  Created by Ikbal Demirdoven on 2023-11-12.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift
import Firebase

class AuthService {
    
    @Published var userSession : FirebaseAuth.User?
    @Published var currentUser : User?
    
    static let shared = AuthService()
    
    init() {
        Task {
            try await loadUserData()
        }
    }
    
    @MainActor
    func login(email : String, password : String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            try await loadUserData()
        } catch {
            print("Debug : Failed to log in the user with error ; \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func createUser(email : String, password : String, username : String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            await uploadUserData(uid: result.user.uid, email: email, username: username)
        } catch {
            print("Debug : Failed to register the user with error ; \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func loadUserData() async throws {
        guard let currentUid = userSession?.uid else { return }
        self.userSession = Auth.auth().currentUser
        let snapshot = try  await Firestore.firestore().collection("users").document(currentUid).getDocument()
        self.currentUser =  try? snapshot.data(as: User.self)
    }
    
    func signOut() {
        try? Auth.auth().signOut()
        self.userSession = nil
        self.currentUser = nil
    }
    private func uploadUserData(uid: String, email : String, username : String) async {
        let user = User(id: uid, email: email, username: username)
        self.currentUser = user
        guard let encodedUser =  try? Firestore.Encoder().encode(user) else {
            return
        }
        try? await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
    }
}
