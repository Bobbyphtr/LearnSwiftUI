//
//  LoginViewController.swift
//  ArchExperiment
//
//  Created by Bobby Pehtrus on 18/08/22.
//

import UIKit
import SwiftUI

/// Demonstrate Representable that does not using Coordinator.
class LoginViewController: UIViewController {
    
    let viewModel: LoginViewModel
    lazy var loginView: LoginView = LoginView(viewModel: viewModel)
    
    private lazy var viewHostingController = UIHostingController(rootView: loginView)
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        printLog("init")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSwiftUIView()
    }
    
    deinit {
        printLog("deinit")
    }
    
    private func configureSwiftUIView() {
        /// Add as a child of the current view controller.
        addChild(viewHostingController)
        
        /// Add the SwiftUI view to the view controller view hierarchy.
        view.addSubview(viewHostingController.view)

        /// Setup the constraints to update the SwiftUI view boundaries.
        viewHostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewHostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            viewHostingController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            view.bottomAnchor.constraint(equalTo: viewHostingController.view.bottomAnchor),
            view.rightAnchor.constraint(equalTo: viewHostingController.view.rightAnchor)
        ])

        /// Notify the hosting controller that it has been moved to the current view controller.
        viewHostingController.didMove(toParent: self)
    }
}

