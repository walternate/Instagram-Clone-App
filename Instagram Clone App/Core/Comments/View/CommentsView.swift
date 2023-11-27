//
//  CommentsView.swift
//  Instagram Clone App
//
//  Created by Ikbal Demirdoven on 2023-11-23.
//

import SwiftUI

struct CommentsView: View {
    @State private var comment = ""
    @StateObject var viewModel : CommentViewModel
    private var currentUser : User? {
        return UserService.shared.currentUser
    }
    init(post : Post) {
        self._viewModel = StateObject(wrappedValue: CommentViewModel(post: post))
    }
    var body: some View {
        VStack {
            Text("Comments")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.top, 24)
            Divider()
            ScrollView {
                LazyVStack(spacing: 24) {
                    ForEach(viewModel.comments) {
                        comment in
                        CommentsCell(comment: comment)
                    }
                }
            }
            .padding(.top)
            
            Divider()
            HStack(spacing: 12) {
                CircularProfileImageView(user: currentUser, size: .xSmall)
                ZStack(alignment: .trailing) {
                    TextField("Add a comment...", text: $comment)
                        .font(.footnote)
                        .padding(12)
                        .padding(.trailing, 40)
                        .overlay {
                            Capsule()
                                .stroke(Color(.systemGray5), lineWidth: 1)
                        }
                    Button {
                        Task { try await viewModel.uploadComment(commentText: comment)
                            comment = ""}
                    } label: {
                        Text("Post")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.blue)
                        
                    }
                    .padding(.horizontal)
                }
            }
            .padding()
        }
    }
}

#Preview {
    CommentsView(post: Post.MOCK_POSTS[0])
}
