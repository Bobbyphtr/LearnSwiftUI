//
//  Coordinator.swift
//  ArchExperiment
//
//  Created by Bobby Pehtrus on 18/08/22.
//

import Foundation
import UIKit

protocol Coordinator {
    var activeNavigationController: UINavigationController { get set }
    
    func start()
}

class LoginRegisterCoordinator: Coordinator {
    var activeNavigationController: UINavigationController
    
    init(activeNavigationController: UINavigationController) {
        self.activeNavigationController = activeNavigationController
    }
    
    func start() {
        // First Start
        onBoarding()
    }
    
    private func onBoarding() {
        let viewCon: UIViewController = OnBoardingViewController(navigationDelegate: self)
        activeNavigationController.pushViewController(viewCon, animated: true)
    }
    
    private func goToLogin() {
        let viewModel: LoginViewModel = LoginViewModel()
        let viewCon: UIViewController = LoginViewController(viewModel: viewModel)
        activeNavigationController.pushViewController(viewCon, animated: true)
    }
    
    private func goToRegister() {
        let viewModel: RegisterViewModel = RegisterViewModel()
        let viewCon: UIViewController = RegisterViewController(viewModel: viewModel)
        activeNavigationController.pushViewController(viewCon, animated: true)
    }
    
    deinit {
        print("Coordinator deinit")
    }
}

extension LoginRegisterCoordinator: OnBoardingNavigationDelegate {
    func onBoardingDidLoginTapped() {
        goToLogin()
    }
    
    func onBoardingDidRegisterTapped() {
        goToRegister()
    }
    
}
