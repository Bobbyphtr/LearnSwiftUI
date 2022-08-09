//
//  BasicAsyncImage.swift
//  AsyncImageTutorial
//
//  Created by Bobby Pehtrus on 09/08/22.
//

import SwiftUI

struct BasicAsyncImage: View {
    
    let imageURL: String
    
    var body: some View {
        VStack {
            Text("Basic AsyncImage")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
            Text("This is a basic AsyncImage, since it is quite large I will wrap it around a ScrollView")
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
            ScrollView([.horizontal, .vertical], showsIndicators: true, content: {
                // MARK: BASIC
                AsyncImage(url: URL(string: imageURL))
            })
            .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
        }
    }
}
