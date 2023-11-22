//
//  EditProfileViewModel.swift
//  Instagram Clone App
//
//  Created by Ikbal Demirdoven on 2023-11-15.
//

import PhotosUI
import Firebase
import SwiftUI

@MainActor
class EditProfileViewModel : ObservableObject {
    @Published var user : User
    @Published var fullname = ""
    @Published var bio = ""
    @Published var profileImage : Image?
    @Published var selectedImage: PhotosPickerItem?
    {
        didSet
        {
            Task
            {
                await loadImage(item: selectedImage)
            }
        }
    }
    private var uiImage : UIImage?

    init(user: User) {
        self.user = user
        if let fullname = user.fullname {
            self.fullname = fullname
        }
        if let bio = user.bio {
            self.bio = bio
        }
    }
    func loadImage(item : PhotosPickerItem?) async {
        guard let item = item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
    }
    
    func updateUserData() async throws {
        var data = [String : Any]()
        //update profile image if changed
        if let uiImage = uiImage {
            let imageURL = try await ImageUploader.uploadImage(image: uiImage)
            data["profileImageURL"] = imageURL
        }
        //update name if changed
        if !fullname.isEmpty && user.fullname != fullname {
            data["fullname"] = fullname
        }
        
        //update bio if changed
        if !bio.isEmpty && user.bio != bio {
            data["bio"] = bio
        }
        if !data.isEmpty {
            try await Firestore.firestore().collection("users").document(user.id).updateData(data)
        }
    }
    
}
