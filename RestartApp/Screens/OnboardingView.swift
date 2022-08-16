//
//  OnboardingView.swift
//  RestartApp
//
//  Created by Bobby Pehtrus on 14/08/22.
//

import Foundation
import SwiftUI

struct OnboardingView: View {
    
    /// When the program found a key 'onboarding' in the @AppStorage wrapper, then the initialization is skipped. So it doesn't mean always setting the var to true
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    /// When change, some components will starts animating.
    @State private var isAnimating: Bool = false
    
    @State private var imageOffset: CGSize = CGSize.zero
    /// Indicator opacity
    @State private var indicatorOpacity: Double = 1.0
    /// Title text.
    @State private var titleText: String = "Share."
    /// Can only be tested on real device
    let hapticFeedback = UINotificationFeedbackGenerator()
    
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            VStack(spacing: 20.0) {
                Spacer()
                // HEADER
                VStack {
                    /// Changing title text is not making `Text` View updating.
                    Text(titleText)
                        .font(.system(size: 60.0))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(titleText) /// Changing the id will make SwiftUI recognize the text change and refresh the View.
                    Text("""
                    Its not how much we give,
                    but how much love with put in giving.
                    """)
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10.0)
                } // :HeaderVStack
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimating)
              
                // Center
                ZStack {
                    CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                        .offset(x: imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width / 5))
                        .animation(.easeOut(duration: 1), value: imageOffset)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeIn(duration: 0.5), value: isAnimating)
                        .offset(x: imageOffset.width * 1.2, y: 0.0)
                        .rotationEffect(.degrees(Double(imageOffset.width / 20.0)))
                        .gesture(
                            DragGesture()
                                .onChanged({ gesture in
                                    if abs(imageOffset.width) <= 150 {
                                        imageOffset = gesture.translation
                                        withAnimation(.linear(duration: 0.25)) {
                                            indicatorOpacity = 0
                                            titleText = "Give."
                                        }
                                    }
                                })
                                .onEnded({ _ in
                                    imageOffset = .zero
                                    
                                    withAnimation(.linear(duration: 0.25)) {
                                        indicatorOpacity = 1.0
                                        titleText = "Share."
                                    }
                                })
                        )
                        .animation(.easeOut(duration: 1.0), value: imageOffset)
                } // :CenterZStack
                .overlay(
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 44.0, weight: .ultraLight))
                        .foregroundColor(.white)
                        .offset(y: 20.0)
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 1.0).delay(2), value: isAnimating)
                        .opacity(indicatorOpacity)
                    , alignment: .bottom
                )
                
                Spacer()
                // Bottom
                SlideButton()
                    .onSwipedToRight {
                        // Use animation when change screen.
                        withAnimation(Animation.easeOut(duration: 0.4)) {
                            isOnboardingViewActive = false
                            playSound(sound: "chimeup", type: "mp3")
                            hapticFeedback.notificationOccurred(.success)
                        }
                    }
                    .onCancelledSwiped {
                        hapticFeedback.notificationOccurred(.warning)
                    }
                    .opacity(isAnimating ? 1 : 0)
                    .offset(y: isAnimating ? 0 : 40)
                    .animation(.easeOut(duration: 1), value: isAnimating)
            } // :VStack
        } // :ZStack
        .onAppear {
            isAnimating = true
        }
        .preferredColorScheme(.dark)
    }
}

struct OnboardingView_PreviewProvider: PreviewProvider {
    
    static var previews: some View {
        OnboardingView()
    }
    
}
