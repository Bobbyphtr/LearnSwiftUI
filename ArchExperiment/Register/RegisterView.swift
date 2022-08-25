//
//  RegisterView.swift
//  ArchExperiment
//
//  Created by Bobby Pehtrus on 18/08/22.
//

import Combine
import SwiftUI

struct RegisterView: View {
    
    let interactor: RegisterViewInteractor = RegisterViewInteractor()
    
    @ObservedObject var viewModel : RegisterViewModel
    
    var usernameText: AnyCancellable?
    
    var body: some View {
        VStack(spacing: 16.0) {
            
            Text("Register")
                .font(.title)
            
            TVLViewSwiftUI { _ in
                let tf = CustomUITextField()
                tf.placeholder = "Username"
                tf.errorText = "This is username error text."
                tf.translatesAutoresizingMaskIntoConstraints = false
                tf.textfield.addTarget(interactor, action: #selector(interactor.onUsernameFieldDidChanged(_:)), for: .editingChanged)
                interactor.onUsernameFieldDidChanged = { [weak viewModel] fieldText in
                    viewModel?.onUsernameFieldChanged(fieldText.text ?? "")
                }
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
        .onAppear(perform: {
            interactor.viewModel = viewModel
        })
        .padding(.horizontal, 16.0)
        
    }
    
    class RegisterViewInteractor: NSObject, UITextFieldDelegate {
        
        // This is optional to have. But it could make things easier.
        weak var viewModel: RegisterViewModel?
        
        var onUsernameFieldDidChanged: ((_ textfield: UITextField) -> Void)?
        
        @objc func onUsernameFieldDidChanged(_ textfield: UITextField) {
            printLog("onUsernameFieldDidChagned \(textfield.text)")
            // We cant do this here, but we can create a callback.
//            viewModel.onUsernameFieldChanged(textfield.text ?? "")
           onUsernameFieldDidChanged?(textfield)
            
        }
        
        deinit {
            printLog("Deinit")
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(viewModel: RegisterViewModel())
    }
}
