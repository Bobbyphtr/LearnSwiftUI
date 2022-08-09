//
//  AnimationAsyncImage.swift
//  AsyncImageTutorial
//
//  Created by Bobby Pehtrus on 09/08/22.
//

import SwiftUI

struct AnimationAsyncImage: View {
    
    let imageURL: String
    
    var body: some View {
        Text("Animation AsyncImage")
            .font(.title)
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
        Text("You can add animations inside phases!")
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
        // You can only test this on Simulator.
        AsyncImage(url: URL(string: imageURL), transaction: Transaction(animation: .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.25)
        )) { phase in
            switch phase {
            case .success(let image):
                image
                    .imageModifier()
//                    .transition(.move(edge: .bottom))
//                    .transition(.slide)
                    .transition(.scale)
            case .failure(_):
                Image(systemName: "ant.circle.fill").iconModifier()
            case .empty:
                Image(systemName: "photo.circle.fill").iconModifier()
            @unknown default:
                fatalError("Unknown phase")
            }
        }
        .padding(40.0)
    }
}

struct AnimationAsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        AnimationAsyncImage(imageURL: "https://credo.academy/credo-academy@3x.png")
    }
}
