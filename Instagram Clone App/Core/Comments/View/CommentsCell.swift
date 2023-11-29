//
//  CommentsCell.swift
//  Instagram Clone App
//
//  Created by Ikbal Demirdoven on 2023-11-23.
//

import SwiftUI

struct CommentsCell: View {
    private var user : User? {
        return comment.user
    }
    let comment : Comment
    var body: some View {
        HStack {
            CircularProfileImageView(user: user, size: .xSmall)
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 2) {
                    Text(user?.username ?? "")
                        .fontWeight(.semibold)
                    Text(comment.timestamp.timestampString())
                        .foregroundStyle(.gray)
                    
                }
                Text(comment.commentText)
            }
            .font(.caption)
            Spacer()
        }
        .padding(.horizontal)
    }
}

