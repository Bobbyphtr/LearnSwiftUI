//
//  NoItemsView.swift
//  TodoList
//
//  Created by Bobby Pehtrus on 02/08/22.
//

import SwiftUI

struct NoItemsView: View {
    
    @State var animate: Bool = false
    
    var body: some View {
        VStack(spacing: 10.0) {
            Text("📭")
                .font(.system(size: 48.0))
            Text(LocalizedStringKey(NSLocalizedString("no-items-title", comment: "")))
                .font(.title)
                .fontWeight(.semibold)
            Text("no-items-description")
                .font(.subheadline)
            NavigationLink(
                destination: AddView(),
                label: {
                    Text("Lets Begin! 🏃‍♂️")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height:55.0)
                        .frame(maxWidth: .infinity)
                        .background(animate ?  Color.red : Color.accentColor)
                        .cornerRadius(10)
                    
                })
            .padding(.horizontal, animate ? 30 : 50)
            .shadow(color: animate ? Color.red.opacity(0.7) : Color.accentColor.opacity(0.7),
                    radius: animate ? 30: 10,
                    x: 0.0,
                    y: animate ? 50 : 30)
            .scaleEffect(animate ? 1.1: 1.0)
            .offset(y: animate ? 7 : 0)
        }
        .multilineTextAlignment(.center)
        .padding(.top, -175)
        .padding(.horizontal, 16)
        .onAppear(perform: addAnimation)
    }
    
    func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
}


struct NoItemsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NoItemsView()
        }.navigationTitle("Any Title")
    }
}
