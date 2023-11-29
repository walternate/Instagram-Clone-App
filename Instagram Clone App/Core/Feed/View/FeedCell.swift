//
//  FeedCell.swift
//  Instagram Clone App
//
//  Created by Ikbal Demirdoven on 2023-11-08.
//

import SwiftUI
import Kingfisher

struct FeedCell: View {
    @ObservedObject var viewModel : FeedCellViewModel
    @State private var showComments = false
    private var post : Post {
        return viewModel.post
    }
    init(post: Post) {
        self.viewModel = FeedCellViewModel(post: post)
    }
    
    private var didLike : Bool {
        return post.didLike ?? false
    }
    var body: some View {
        VStack {
            //image + plus username
            HStack {
                if let user = post.user {
                    CircularProfileImageView(user: user, size: .xSmall)
                    Text(user.username)
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                Spacer()
            }
            .padding(.leading, 8)
            //post image
            KFImage(URL(string: post.imageURL))
                .resizable()
                .scaledToFill()
                .frame(height: 400)
                .clipShape(Rectangle())
            
            //action buttons
            HStack(spacing: 16) {
                Button {
                    handleLikeTapped()
                } label: {
                    Image(systemName: didLike ? "heart.fill" : "heart")
                        .imageScale(.large)
                        .foregroundStyle(didLike ? .red : .black)
                }
                Button {
                    showComments.toggle()
                    
                } label: {
                    Image(systemName: "bubble.right")
                        .imageScale(.large)
                }
                Button {
                    print("share")
                    
                } label: {
                    Image(systemName: "paperplane")
                        .imageScale(.large)
                }
                Spacer()
            }
            .padding(.leading, 8)
            .foregroundStyle(.black)
            .padding(.top, 4)
            
            //likes label
            if post.likes > 0 {
                Text("\(post.likes) likes")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                    .padding(.top, 1)
            }
            //caption label
            HStack {
                Text("\(post.user?.username ?? "") ").fontWeight(.semibold) +
                Text("\(post.caption)")
            }
            .font(.footnote)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 10)
            .padding(.top, 1)
            //timestamp
            Text(post.timeStamp.timestampString())
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 10)
                .padding(.top, 1)
                .foregroundStyle(.gray)
        }
        .sheet(isPresented: $showComments) {
            CommentsView(post: post)
                .presentationDragIndicator(.visible)
        }
    }
    private func handleLikeTapped() {
        Task {
            if didLike {
                try await viewModel.unlike()
            } else {
                try await viewModel.like()
            }
        }
    }
}

#Preview {
    FeedCell(post: Post.MOCK_POSTS[0])
}
