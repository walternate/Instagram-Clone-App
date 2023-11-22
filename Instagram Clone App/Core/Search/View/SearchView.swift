//
//  SearchView.swift
//  Instagram Clone App
//
//  Created by Ikbal Demirdoven on 2023-11-09.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @StateObject var viewModel = SearchViewModel()
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.users) {
                        user in
                        NavigationLink(value: user) {
                            HStack {
                                CircularProfileImageView(user: user, size: .xSmall)
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
