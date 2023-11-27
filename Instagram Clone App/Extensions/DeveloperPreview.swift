//
//  DeveloperPreview.swift
//  Instagram Clone App
//
//  Created by Ikbal Demirdoven on 2023-11-25.
//

import SwiftUI
import Firebase

extension PreviewProvider {
    static var dev : DeveloperPreview {
        return DeveloperPreview.shared
    }
}

class DeveloperPreview {
    static let shared = DeveloperPreview()
    let comment = Comment(commentOwnerUid: "123", commentText: "Test comment", postId: "1234", postOwnerUid: "123", timestamp: Timestamp())
}
