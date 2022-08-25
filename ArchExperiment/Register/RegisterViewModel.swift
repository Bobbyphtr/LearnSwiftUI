//
//  RegisterViewModel.swift
//  ArchExperiment
//
//  Created by Bobby Pehtrus on 25/08/22.
//

import Foundation
import UIKit

class RegisterViewModel: NSObject, ObservableObject {
    
    func onUsernameFieldChanged(_ text: String) {
        printLog("onUsernameFieldChanged \(text)")
    }
    
    
    deinit {
        printLog("Deinit")
    }
}



