//
//  AsyncImageView.swift
//  TetHomeTask
//

import SwiftUI

struct AsyncImageView: View {
    let url: String
    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("Loading is failed")
            } else {
                ProgressView()
            }
        }
        .frame(height: 64)
    }
}
