//
//  RegisterView.swift
//  ArchExperiment
//
//  Created by Bobby Pehtrus on 18/08/22.
//

import SwiftUI

struct RegisterView: View {
    var body: some View {
            VStack(spacing: 16.0) {
                
                Text("Register")
                    .font(.title)
                
                TVLViewSwiftUI { _ in
                    let tf = CustomUITextField()
                    tf.placeholder = "This is a placeholder"
                    tf.errorText = "This is error text. This is a super long and long and long erro text. Should be go to the second line."
                    tf.translatesAutoresizingMaskIntoConstraints = false
                    return tf
                }
                .fixedSize(horizontal: false, vertical: true)
                
                TVLViewSwiftUI ({ context in
                    let customTf = CustomUITextField()
                    customTf.placeholder = "Password"
                    customTf.errorText = "Password Error text"
                    customTf.translatesAutoresizingMaskIntoConstraints = false
                    return customTf
                })
                .fixedSize(horizontal: false, vertical: true)

                TVLViewSwiftUI { _ in
                    let btn = CustomButton(style: .primary)
                    btn.setTitle("Register", for: .normal)
                    return btn
                }
                .fixedSize()
            }
            .padding(.horizontal, 16.0)
     
        }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
