//
//  SecondView.swift
//  LearnSwiftUI
//
//  Created by Bobby Pehtrus on 08/08/22.
//

import SwiftUI

struct SecondView: View {
    var body: some View {
        NavigationLink("Let's start the game!") {
            ContentView()
        }
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}
