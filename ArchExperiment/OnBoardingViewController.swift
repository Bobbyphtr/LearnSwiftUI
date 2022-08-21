//
//  OnBoardingViewController.swift
//  ArchExperiment
//
//  Created by Bobby Pehtrus on 18/08/22.
//

import Foundation
import UIKit


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
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.text = "Here we demonstrate SwiftUI x UIKit interoperability"
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8.0
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mainStackView)
        
        
    }
    
}
