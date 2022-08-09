//
//  MainView.swift
//  AsyncImageTutorial
//
//  Created by Bobby Pehtrus on 09/08/22.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            ZStack { // Somewhat it needs this container to run animation transitions
                ContentView()
            }
            .animation(.default, value: true)
        }
       
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
