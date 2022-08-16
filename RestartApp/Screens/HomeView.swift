//
//  HomeView.swift
//  RestartApp
//
//  Created by Bobby Pehtrus on 14/08/22.
//

import Foundation
import SwiftUI

struct HomeView: View {
    
    /// WE ARE NOT SETTING IT TO FALSE. `false` if onboarding is not found.
    @AppStorage("onboarding") var isOnboardingActive = false
    
    @State private var isAnimating: Bool = false
    
    var body: some View {
      
        VStack(spacing: 20.0) {
            Spacer()
            ZStack {
                CircleGroupView(ShapeColor: Color.gray, ShapeOpacity: 0.1)
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .offset(y: isAnimating ? 35.0 : -35.0)
                    .animation(
                        Animation
                            .easeInOut(duration: 4.0)
                            .repeatForever()
                        ,value: isAnimating
                    )
            } // :ZStack
            
            Text("The time that leads to mastery is dependent on the intensity of our focus")
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(Color.secondary)
            
            .multilineTextAlignment(.center)
                .padding()
            Spacer()
            
            Button {
                // Do operation
                withAnimation {
                    isOnboardingActive = true
                    playSound(sound: "success", type: "m4a")
                }
            } label: {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                Text("Restart")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
        } // :VSTACK
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                isAnimating = true
            })
        }
    }
}

struct HomeView_PreviewProvider: PreviewProvider {
    
    static var previews: some View {
        HomeView()
    }
    
}
