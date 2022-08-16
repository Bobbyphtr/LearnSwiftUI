//
//  SlideButton.swift
//  RestartApp
//
//  Created by Bobby Pehtrus on 14/08/22.
//

import SwiftUI

struct SlideButton: View {
    
    /// Represent the width that will be changed when dragged.
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80.0
    /// Represent offset value in horizontal direction.
    @State private var buttonOffset: CGFloat = 0.0
    /// Action when button has fully swiped to right
    private var onSwipedToRightAction: (() -> Void)? = nil
    private var onCancelledAction: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            // Background
            Capsule()
                .fill(Color.white.opacity(0.2))
            Capsule()
                .fill(Color.white.opacity(0.2))
                .padding(8.0)
            // Text
            Text("Get Started")
                .font(.title3)
                .fontWeight(.heavy)
                .foregroundColor(.white)
                .offset(x: 20.0)
            
            // Extending background capsule
            HStack {
                Capsule()
                    .fill(Color("ColorRed"))
                    .frame(width:buttonOffset + 80)
                Spacer()
            } // :CAPSULE
            
            HStack {
                ZStack {
                    Circle()
                        .fill(Color("ColorRed"))
                        .frame(width:80.0)
                    Circle()
                        .fill(Color.black.opacity(0.15))
                        .frame(width:80.0)
                        .padding(8.0)
                    Image(systemName: "chevron.right.2")
                        .font(.system(size: 24.0, weight: .bold))
                }
                .foregroundColor(.white)
                .frame(width: 80.0, height: 80.0, alignment: .center)
                .offset(x: buttonOffset)
                .gesture(
                    // Creating a drag resture
                    DragGesture()
                        .onChanged { gesture in
                            // It will only run when the draggin has been started to the right direction
                            if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80.0 {
                              
                                buttonOffset = gesture.translation.width
                            }
                        }
                        .onEnded({ _ in
                            if buttonOffset > buttonWidth / 2 {
                                buttonOffset = buttonWidth - 80.0
                                onSwipedToRightAction?()
                            }
                            else {
                                // When stopped tracking back to zero
                                buttonOffset = 0
                                onCancelledAction?()
                            }
                        })
                )
                
                Spacer()
            } // :CIRCLE BUTTON
            
        }
        .frame(width: buttonWidth, height: 80.0, alignment: .center)
        .padding()
    }
    
    /// Represent red button is snapped to right
    public func onSwipedToRight(_ action: @escaping (() -> Void) ) -> Self {
        var view = self
        view.onSwipedToRightAction = action
        return view
    }
    
    public func onCancelledSwiped(_ action: @escaping (() -> Void)) -> Self {
        var view = self
        view.onCancelledAction = action
        return view
    }
}

struct SlideButton_PreviewProvider: PreviewProvider {
    
    static var previews: some View {
        ZStack {
            Color("ColorBlue")
            SlideButton()
        }
        .previewLayout(.sizeThatFits)
    }
    
}
