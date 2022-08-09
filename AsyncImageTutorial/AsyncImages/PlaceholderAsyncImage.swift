//
//  PlaceholderAsyncImage.swift
//  AsyncImageTutorial
//
//  Created by Bobby Pehtrus on 09/08/22.
//

import SwiftUI

struct PlaceholderAsyncImage: View {
    
    let imageURL: String
    
    var body: some View {
        VStack{
            Text("Placeholder AsyncImage")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
            Text("Custom Placeholder helps you to handle when the image loads")
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
            // MARK: Custom Placeholder
            AsyncImage(url: URL(string: imageURL)) { image in
                // We can add custom modifier when the image loads.
                image
                    .imageModifier()
            } placeholder: {
                // We can put anything here. Even an activity indicator with animation!
                Image(systemName: "photo.circle.fill")
                    .iconModifier()
            }
            .padding(40.0)
            // Note that we dont want to add modifiers on the AsyncImage, instead we added inside the closures provided.
        }
    }
}

// Tips: You can add an extension for Image. With these, you can reuse code.
extension Image {
    func imageModifier() -> some View {
        self
            .resizable()
            .scaledToFit()
    }
    
    func iconModifier() -> some View {
        self
            .imageModifier()
            .frame(maxWidth: 128)
            .foregroundColor(.purple)
            .opacity(0.5)
    }
}
