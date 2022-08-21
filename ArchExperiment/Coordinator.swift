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
        goToHome()
    }
    
    private func goToHome() {
        let viewModel: LoginViewModel = LoginViewModel()
        let viewCon: UIViewController = LoginViewController(viewModel: viewModel)
        activeNavigationController.pushViewController(viewCon, animated: false)
    }
    
}
