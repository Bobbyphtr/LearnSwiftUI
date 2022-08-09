//
//  CustomAppDelegate.swift
//  LearnSwiftUI
//
//  Created by Bobby Pehtrus on 08/08/22.
//

import UIKit

class CustomAppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("CustomAppDelegate: willFinishLaunchingWithOptions")
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("CustomAppDelegate: didFinishLaunchingWithOptions")
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Not triggered since SwiftUI uses Scenes
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Not triggered since SwiftUI uses Scenes
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Not trigerred since SwiftUI uses Scenes
    }
}
