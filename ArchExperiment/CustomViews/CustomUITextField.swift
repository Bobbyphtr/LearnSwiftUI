//
//  CustomUITextField.swift
//  LearnSwiftUI
//
//  Created by Bobby Pehtrus on 08/08/22.
//

import Combine
import Foundation
import UIKit

class CustomUITextField: UITextField {
    
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .map { ($0.object as? UITextField)?.text  ?? "" }
            .eraseToAnyPublisher()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 0, height: 55.0)
    }
    
    deinit {
        print("TextField deinit")
    }
    
}
