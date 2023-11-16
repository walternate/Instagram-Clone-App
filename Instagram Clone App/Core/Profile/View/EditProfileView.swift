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
    @State var selectedImage : PhotosPickerItem?
    @State var fullName = ""
    @State var bio = ""
    
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
                        print("Update profile info")
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
            PhotosPicker(selection: $selectedImage) {
                VStack {
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundStyle(.white)
                        .background(.gray)
                        .clipShape(.circle)
                    Text("Edit profile picture")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    Divider()
                }
            }
            .padding(.vertical)
            //edit profile info
            VStack {
                EditProfileRowView(title: "Name", placeHolder: "Enter your name", text: $fullName)
                EditProfileRowView(title: "Bio", placeHolder: "Enter your bio", text: $bio)
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
    EditProfileView()
}
