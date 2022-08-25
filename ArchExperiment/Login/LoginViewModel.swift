//
//  ViewModel.swift
//  ArchExperiment
//
//  Created by Bobby Pehtrus on 18/08/22.
//

import Combine
import Foundation

protocol LoginNavigationDelegate: AnyObject {
    func loginDidSuccess()
    func loginDidTappedRegister()
}

/// ViewModel
/// The ViewModel objc now represents what the View looks.
class LoginViewModel: NSObject, ObservableObject {
    
    weak var navigationDelegate: LoginNavigationDelegate?
    
    // Communicate to the SwiftUI View and conforms Observable Object. SwiftUI View can subscribe these values.
    @Published private(set) var usernameErrorText: String?
    @Published private(set) var passwordErrorText: String?
    
    // SwiftUI View can modify these values
    @Published var username: String = ""
    @Published var password: String = ""
    
    var usernameSub: AnyCancellable?
    var passwordSub: AnyCancellable?
    
    override init() {
        super.init()

        // Binds on username change
        usernameSub = $username.sink(receiveCompletion: { [weak self] _ in
            self?.printLog("UsernameSub receiveCompletion triggered")
        }, receiveValue: { [weak self] _ in
            self?.onUsernameFieldChange()
        })
        
        passwordSub = $password.sink(receiveCompletion: { [weak self] _ in
            self?.printLog("PasswordSub receiveCompletion triggered")
        }, receiveValue: { [weak self] _ in
            self?.onPasswordFieldChange()
        })
        
        printLog("init")

    }
    
    deinit {
        printLog("Deinit")
    }
    
    func onViewDidLoad() {
        printLog("onViewDidLoad")
    }
    
    func onLoginSuccess() {
        navigationDelegate?.loginDidSuccess()
    }
    
    func onLoginButtonTapped() {
        printLog("onLoginButtonTapped(username: \(username), password: \(password)")
        if validate() {
            navigationDelegate?.loginDidSuccess()
        }
    }
    
    func onUsernameFieldChange() {
        usernameErrorText = nil
    }
    
    func onPasswordFieldChange() {
        passwordErrorText = nil
    }
    
    private func validate() -> Bool {
        var isValid = true
        
        if username.isEmpty {
            usernameErrorText = "Username Field should not be empty!"
            isValid = false
        }
        
        if password.isEmpty {
            passwordErrorText = "Password Field should not be empty!"
            isValid = false
        }
        
        return isValid
    }
}
