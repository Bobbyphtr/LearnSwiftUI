//
//  MyViewController.swift
//  LearnSwiftUI
//
//  Created by Bobby Pehtrus on 08/08/22.
//

import Foundation
import UIKit

class MyViewController: UIViewController {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "This is a ViewController"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MyViewController: ViewDidLoad")
        
        view.backgroundColor = UIColor.cyan
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("MyViewController: viewWillAppear")
    }
    
    public func updateLabel(text: String) {
        self.label.text = text
    }
    
    deinit {
        print("MyViewController: Deinit")
    }
    
}
