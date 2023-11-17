//
//  LoginView.swift
//  Instagram Clone App
//
//  Created by Ikbal Demirdoven on 2023-11-09.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                //logo
                Image("instagram")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220, height: 100)
                //textfields
                VStack {
                    TextField("Email", text: $viewModel.email)
                        .textInputAutocapitalization(.never)
                        .modifier(TextFieldModifier())
                    SecureField("Password", text: $viewModel.password)
                        .modifier(TextFieldModifier())
                    Button {
                        print("Show forgot password")
                    } label: {
                        Text("Forgot password?")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .padding(.top)
                            .padding(.trailing, 28)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    Button {
                        Task {
                            try await viewModel.signIn()
                        }
                    } label: {
                        Text("Login")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width: 300, height: 44)
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding(.vertical)
                }
                HStack {
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width / 2 - 40, height: 0.5)
                    Text("OR")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width / 2 - 40, height: 0.5)
                }
                .foregroundStyle(.gray)
                Button {
                    print("login with facebook")
                } label: {
                    HStack {
                        Image("facebooklogo")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("Continue with Facebook")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundStyle(.blue)
                    }
                }
                .padding(.top, 8)
                Spacer()
                Divider()
                NavigationLink {
                    AddEmailView()
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(.semibold)
                    }
                    .font(.footnote)
                }
                .padding(.vertical, 16)
            }
        }
    }
}

#Preview {
    LoginView()
}
