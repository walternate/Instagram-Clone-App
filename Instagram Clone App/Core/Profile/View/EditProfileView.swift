//
//  EditProfileView.swift
//  Instagram Clone App
//
//  Created by Ikbal Demirdoven on 2023-11-14.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var editProfileViewModel : EditProfileViewModel
    init(user: User) {
        self._editProfileViewModel = StateObject(wrappedValue: EditProfileViewModel(user: user))
    }
    var body: some View {
        VStack {
            //toolbar
            VStack {
                HStack {
                    Button("Cancel") {
                        dismiss()
                    }
                    Spacer()
                    Text("Edit Profile")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Spacer()
                    Button {
                        Task { try await editProfileViewModel.updateUserData()}
                        dismiss()
                    } label: {
                        Text("Done")
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }
                }
                .padding(.horizontal)
            }
            Divider()
            //edit profile pic
            PhotosPicker(selection: $editProfileViewModel.selectedImage) {
                VStack {
                    if let image = editProfileViewModel.profileImage {
                        image
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundStyle(.white)
                            .background(.gray)
                            .clipShape(.circle)
                    } else {
                        CircularProfileImageView(user: editProfileViewModel.user, size: .large)
                    }
                    Text("Edit profile picture")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    Divider()
                }
            }
            .padding(.vertical)
            //edit profile info
            VStack {
                EditProfileRowView(title: "Name", placeHolder: "Enter your name", text: $editProfileViewModel.fullname)
                EditProfileRowView(title: "Bio", placeHolder: "Enter your bio", text: $editProfileViewModel.bio)
            }
            Spacer()
        }
    }
}

struct EditProfileRowView : View {
    let title : String
    let placeHolder : String
    @Binding var text : String
    var body: some View {
        HStack {
            Text(title)
                .padding(.leading, 8)
                .frame(width: 100, alignment: .leading)
            VStack {
                TextField(placeHolder, text: $text)
                Divider()
            }
        }
        .font(.subheadline)
        .frame(height: 36)
    }
}

#Preview {
    EditProfileView(user: User.MOCK_USERS[0])
}
