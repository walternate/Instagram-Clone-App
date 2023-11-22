//
//  UserStatView.swift
//  Instagram Clone App
//
//  Created by Ikbal Demirdoven on 2023-11-08.
//

import SwiftUI

struct UserStatView: View {
    let value : Int
    let title : String
    var body: some View {
        VStack {
            Text("\(value)")
                .fontWeight(.semibold)
                .font(.subheadline)
            Text(title)
                .font(.footnote)
        }
        .frame(width: 80)
    }
}
#Preview {
    UserStatView(value: 3, title: "Posts")
}
