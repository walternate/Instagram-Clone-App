//
//  MainTabView.swift
//  Instagram Clone App
//
//  Created by Ikbal Demirdoven on 2023-11-08.
//

import SwiftUI

struct MainTabView: View {
    let user : User
    @State private var selectedTabIndex = 0
    var body: some View {
        TabView(selection: $selectedTabIndex) {
            FeedView()
                .tabItem {
                    Image(systemName: "house")
                }
                .onAppear {
                    selectedTabIndex = 0
                }
                .tag(0)
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
                .onAppear {
                    selectedTabIndex = 1
                }
                .tag(1)
            UploadPostView(tabIndex: $selectedTabIndex)
                .tabItem {
                    Image(systemName: "plus.square")
                }
                .onAppear {
                    selectedTabIndex = 2
                }
                .tag(2)

            Text("Notifications")
                .tabItem {
                    Image(systemName: "heart")
                }
                .onAppear {
                    selectedTabIndex = 3
                }
                .tag(3)
            CurrentUserProfileView(user: user)
                .tabItem {
                    Image(systemName: "person")
                }
                .onAppear {
                    selectedTabIndex = 4
                }
                .tag(4)
        }
        .tint(.black)
    }
}

#Preview {
    MainTabView(user : User.MOCK_USERS[0])
}
