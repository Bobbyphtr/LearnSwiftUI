//
//  OnBoardingViewController.swift
//  ArchExperiment
//
//  Created by Bobby Pehtrus on 18/08/22.
//

import Foundation
import UIKit

protocol OnBoardingNavigationDelegate : AnyObject {
    func onBoardingDidLoginTapped()
    func onBoardingDidRegisterTapped()
}


class OnBoardingViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 24.0)
        label.text = "Welcome to Auth"
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Here we demonstrate SwiftUI x UIKit interoperability. Let's begin!"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView: UIStackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, loginButton, registerButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8.0
        stackView.setCustomSpacing(16.0, after: descriptionLabel)
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var loginButton: CustomButton = {
        let btn: CustomButton = CustomButton(style: .primary)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Login Here!", for: .normal)
        btn.addTarget(self, action: #selector(onLoginTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var registerButton: CustomButton = {
        let btn: CustomButton = CustomButton(style: .secondary)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Register Here!", for: .normal)
        btn.addTarget(self, action: #selector(onRegisterTapped), for: .touchUpInside)
        return btn
    }()
    
    private weak var navigationDelegate: OnBoardingNavigationDelegate?
    
    init(navigationDelegate:OnBoardingNavigationDelegate) {
        self.navigationDelegate = navigationDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: loginButton.frame.height),
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16.0)
        ])
    }
    
    @objc func onLoginTapped() {
        navigationDelegate?.onBoardingDidLoginTapped()
    }
    
    @objc func onRegisterTapped() {
        navigationDelegate?.onBoardingDidRegisterTapped()
    }
    
}
