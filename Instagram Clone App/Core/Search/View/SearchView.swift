//
//  SearchView.swift
//  Instagram Clone App
//
//  Created by Ikbal Demirdoven on 2023-11-09.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(User.MOCK_USERS) {
                        user in
                        NavigationLink(value: user) {
                            HStack {
                                Image(user.profileImageURL ?? "person")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 40, height: 40)
                                    .clipShape(.circle)
                                VStack(alignment: .leading) {
                                    Text(user.username)
                                        .fontWeight(.semibold)
                                    if let fullName = user.fullname {
                                        Text(fullName)
                                    }
                                }
                                .font(.footnote)
                                Spacer()
                            }
                            .foregroundStyle(.black)
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, prompt: "Search")
            .padding(.top, 8)
            .navigationDestination(for: User.self, destination: {
                user in
                ProfileView(user: user)
            })
        }
    }
}

#Preview {
    SearchView()
}
