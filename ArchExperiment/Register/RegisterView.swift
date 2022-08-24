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
                
                TVLViewSwiftUI ({ _ in
                    let customTf = CustomUITextField()
                    customTf.placeholder = "Name"
                    customTf.errorText = "Username error text dkosdk sodk sokd osdk osdk sodk sokd sodk osdk oskdosdk sokdoskd osd kos kd"
                    customTf.translatesAutoresizingMaskIntoConstraints = false
                    return customTf
                })
                .frame(width: .infinity)
                .fixedSize(horizontal: false, vertical: true)
                
                TVLViewSwiftUI ({ context in
                    let customTf = CustomUITextField()
                    customTf.placeholder = "Name"
                    customTf.errorText = "Username error text dkosdk sodk sokd osdk osdk sodk sokd sodk osdk oskdosdk sokdoskd osd kos kd"
                    customTf.translatesAutoresizingMaskIntoConstraints = false
                    return customTf
                })
                .frame(width: .infinity)
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
