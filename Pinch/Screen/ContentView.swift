//
//  ContentView.swift
//  Pinch
//
//  Created by Bobby Pehtrus on 21/08/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isAnimated: Bool = false
    @State private var imageScale: CGFloat = 1.0
    @State private var imageOffset: CGSize = CGSize.zero
    @State private var isDrawerOpen: Bool = false
    
    let pages: [Page] = pagesData
    @State private var pageIndex: Int = 1
    
    func resetImageState() {
        return withAnimation(.spring()) {
            imageScale = 1.0
            imageOffset = .zero
        }
    }
    
    func currentPage() -> String {
        return pages[pageIndex - 1].imageName
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.clear
                // Page Image
                Image(currentPage())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10.0)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimated ? 1 : 0)
                    .animation(.linear(duration: 1), value: isAnimated)
                    .offset(x: imageOffset.width, y: imageOffset.height)
                    .scaleEffect(imageScale)
                // MARK: Tap Gesture
                    .onTapGesture(count: 2) {
                        if imageScale == 1 {
                            withAnimation(.spring()) {
                                imageScale = 5.0 // Scale up
                            }
                        }
                        else  {
                            resetImageState()
                        }
                    }
                // MARK: Drag Gesture
                    .gesture(DragGesture()
                        .onChanged { value in
                            withAnimation(.linear(duration: 1.0)) {
                                imageOffset = value.translation
                            }
                        }
                        .onEnded({ _ in
                            // if the image is double tapped dont reset.
                            if imageScale <= 1 {
                                resetImageState()
                            }
                        })
                    )
                // MARK: Magnification
                    .gesture(
                        MagnificationGesture()
                            .onChanged({ value in
                                withAnimation(.linear(duration: 1.0)) {
                                    if imageScale >= 1 && imageScale <= 5.0 {
                                        imageScale = value
                                    }
                                    else if imageScale > 5 {
                                        imageScale = 5
                                    }
                                }
                            })
                            .onEnded({ _ in
                                // only magnify between 1 to 5
                                if imageScale > 5 {
                                    imageScale = 5
                                }
                                else if imageScale <= 1 {
                                    resetImageState()
                                }
                            })
                    )
                
            } //: ZSTACK
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                // do not use withAnimation(.linear) .. here! it will cause problems!
                isAnimated = true
            }
            // MARK: - INFO PANEL
            .overlay(
                InfoPanelView(scale: imageScale, offset: imageOffset)
                    .padding(.horizontal)
                    .padding(.top, 30.0)
                , alignment: .top
            )
            // MARK: - CONTROLS
            .overlay(
                Group{
                    HStack {
                        // Scale down
                        Button {
                            withAnimation(.spring()) {
                                if imageScale > 1 {
                                    imageScale -= 1
                                    
                                    if imageScale <= 1 {
                                        resetImageState()
                                    }
                                }
                            }
                        } label: {
                            ControlImageView(icon: "minus.magnifyingglass")
                        }
                        
                        // Reset
                        Button {
                            resetImageState()
                        } label: {
                            ControlImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                        }
                        
                        // Scale Up
                        Button {
                            withAnimation(.spring()) {
                                if imageScale < 5 {
                                    imageScale += 1
                                    
                                    if imageScale > 5 {
                                        imageScale = 5
                                    }
                                }
                            }
                        } label: {
                            ControlImageView(icon: "plus.magnifyingglass")
                        }
                    } //: Controls
                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12.0)
                    .opacity(isAnimated ? 1 : 0)
                }.padding(.bottom, 30.0)
                ,alignment: .bottom
            )
            // MARK: Drawer
            .overlay(
                HStack(spacing: 12) {
                    // Drawer handle
                    Image(systemName: isDrawerOpen ? "chevron.compact.right" : "chevron.compact.left")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40.0)
                        .padding(8.0)
                        .foregroundStyle(.secondary)
                        .onTapGesture {
                            withAnimation(.easeOut) {
                                isDrawerOpen.toggle()
                            }
                        }
                    
                    // Thumbnails
                    ForEach(pages) { item in
                        Image(item.thumbnailName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80.0)
                            .cornerRadius(8.0)
                            .shadow(radius: 4.0)
                            .opacity(isDrawerOpen ? 1 : 0)
                            .animation(.easeOut(duration: 0.5), value: isDrawerOpen)
                            .onTapGesture {
                                isAnimated = true // Whats this for?
                                pageIndex = item.id
                            }
                    }
                    Spacer()
                }
                    .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12.0)
                    .opacity(isAnimated ? 1 : 0)
                    .frame(width: 260.0)
                    .padding(.top, UIScreen.main.bounds.height / 12.0)
                    .offset(x: isDrawerOpen ? 20 : 215)
                , alignment: .topTrailing
            )
        } //: NAVIGATION
        .navigationViewStyle(.stack)
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 13 Pro Max")
    }
}
