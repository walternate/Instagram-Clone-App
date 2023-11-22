//
//  CircularProfileImageView.swift
//  Instagram Clone App
//
//  Created by Ikbal Demirdoven on 2023-11-19.
//

import SwiftUI
import Kingfisher

enum ProfileImageSize {
    case xSmall
    case small
    case medium
    case large
    
    var dimension : CGFloat {
        switch self {
        case .xSmall:
            return 40
        case .small:
            return 48
        case .medium:
            return 64
        case .large:
            return 80
            
        }
    }
}

struct CircularProfileImageView: View {
    let user : User
    let size : ProfileImageSize
    var body: some View {
        if let imageURL = user.profileImageURL {
            KFImage(URL(string: imageURL))
                .resizable()
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(.circle)
            
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(.circle)
                .foregroundStyle(Color(.systemGray4))
        }
    }
}

#Preview {
    CircularProfileImageView(user: User.MOCK_USERS[0], size: .small)
}
