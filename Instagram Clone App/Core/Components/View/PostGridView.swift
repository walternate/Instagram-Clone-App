//
//  PostGridView.swift
//  Instagram Clone App
//
//  Created by Ikbal Demirdoven on 2023-11-11.
//

import SwiftUI
import Kingfisher

struct PostGridView: View {
    @StateObject var postGridViewModel : PostGridViewModel
    
    init(user: User) {
        self._postGridViewModel = StateObject(wrappedValue: PostGridViewModel(user: user))
    }
    private let gridItems : [GridItem] =
    [
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1)
    ]
    private let imageDimension : CGFloat = (UIScreen.main.bounds.width / 3) - 1

    var body: some View {
        LazyVGrid(columns: gridItems, spacing: 1) {
            ForEach(postGridViewModel.posts) {
                post in
                KFImage(URL(string: post.imageURL))
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageDimension, height: imageDimension)
                    .clipped()
            }
        }
    }
}

#Preview {
    PostGridView(user: User.MOCK_USERS[0])
}
