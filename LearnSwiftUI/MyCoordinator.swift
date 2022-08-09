//
//  MyCoordinator.swift
//  LearnSwiftUI
//
//  Created by Bobby Pehtrus on 08/08/22.
//

import Foundation
import UIKit
import SwiftUI

class MyCoordinator: NSObject, SwiftUICoordinator, UITextFieldDelegate {
    
    @Binding var playerScore: Int
    @Binding var aiScore: Int
    
    init(playerScore: Binding<Int>, aiScore: Binding<Int>) {
        self._aiScore = aiScore
        self._playerScore = playerScore
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.aiScore = Int(textField.text ?? "0") ?? -1
    }
}
