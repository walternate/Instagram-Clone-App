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
    init(user: User) {
        self.user = user
    }
    @Published var profileImage : Image?
    @Published var fullName = ""
    @State var bio = ""
    func loadImage(item : PhotosPickerItem?) async {
        guard let item = item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.profileImage = Image(uiImage: uiImage)
    }
    
    func updateUserData() async throws {
        //update profile image if changed
        
        //update name if changed
        if !fullName.isEmpty && fullName != user.fullname {
            print("Debug update: Fullname \(fullName)")
        }
        
        //update bio if changed
        if !bio.isEmpty && bio != user.bio {
            print("Debug update: bio \(bio)")

        }
    }
}
