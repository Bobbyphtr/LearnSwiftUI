//
//  ScaleAsyncImage.swift
//  AsyncImageTutorial
//
//  Created by Bobby Pehtrus on 09/08/22.
//

import SwiftUI

struct ScaleAsyncImage: View {
    
    let imageURL: String
    
    var body: some View {
        VStack {
            Text("Scale AsyncImage")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
            Text("Using scale will help you to size the image.")
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
            // The larger the scale the smaller it gets. 1.0 means original size.
            AsyncImage(url: URL(string: imageURL), scale: 5.0)
        }
    }
}
