//
//  ContentView.swift
//  AsyncImageTutorial
//
//  Created by Bobby Pehtrus on 09/08/22.
//

import SwiftUI

struct ContentView: View {
    private let imageURL: String = "https://credo.academy/credo-academy@3x.png"
    
    var body: some View {
        ScrollView {
            VStack {
                // You can visit each preview provider for detailed view!
                BasicAsyncImage(imageURL: imageURL)
                NavigationButton(title: "Demo Here", destination: AnyView(BasicAsyncImage(imageURL: imageURL)))
                ScaleAsyncImage(imageURL: imageURL)
                NavigationButton(title: "Demo Here", destination: AnyView(ScaleAsyncImage(imageURL: imageURL)))
                PlaceholderAsyncImage(imageURL: imageURL)
                NavigationButton(title: "Demo Here", destination: AnyView(PlaceholderAsyncImage(imageURL: imageURL)))
                PhaseAsyncImage(imageURL: imageURL)
                NavigationButton(title: "Demo Here", destination: AnyView(PhaseAsyncImage(imageURL: imageURL)))
                AnimationAsyncImage(imageURL: imageURL)
                NavigationButton(title: "Demo Here", destination: AnyView(AnimationAsyncImage(imageURL: imageURL)))
            }
            .padding(.horizontal)
        }
        .navigationTitle("AsyncImage Catalog")
    }
}

struct NavigationButton: View {
    
    let title: String
    let destinationView: AnyView
    
    init(title: String, destination: AnyView) {
        self.destinationView = destination
        self.title = title
    }
    
    var body: some View {
        NavigationLink(title, destination: destinationView)
            .padding()
            .background(Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(10.0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
        .previewDevice("iPhone 13 Pro Max")
    }
}
