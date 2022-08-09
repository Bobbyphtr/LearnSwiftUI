//
//  PhaseAsyncImage.swift
//  AsyncImageTutorial
//
//  Created by Bobby Pehtrus on 09/08/22.
//

import SwiftUI

struct PhaseAsyncImage: View {
    
    let imageURL: String
    
    var body: some View {
        Text("Phase AsyncImage")
            .font(.title)
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
        Text("Use Success, Failure and Empty phases to take control of the download process.")
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
        // Phase
        AsyncImage(url: URL(string: imageURL)) { phase in
            // SUCCESS: the image successfully loaded
            // FAILURE: the image failed to load with an error
            // EMPTY: no image is loaded
            switch phase {
            case .success(let image):
                image.imageModifier() // loads image
            case .failure(let error):
                ZStack { // indicates error
                    Color.red
                    Text(error.localizedDescription)
                }
            case .empty:
                ZStack { // indicates placeholder
                    Color.gray
                    Text("Placeholder")
                }
            @unknown default:
                fatalError("Unknows phase")
            }
        }
    }
}

struct PhaseAsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        PhaseAsyncImage(imageURL: "https://credo.academy/credo-academy@3x.png")
    }
}
