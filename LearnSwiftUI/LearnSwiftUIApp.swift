//
//  LearnSwiftUIApp.swift
//  LearnSwiftUI
//
//  Created by Bobby Pehtrus on 01/08/22.
//

import SwiftUI

@main
struct LearnSwiftUIApp: App {
    
    @Environment(\.scenePhase) private var scenePhase

    @UIApplicationDelegateAdaptor(CustomAppDelegate.self) private var appDelegate
    
    init() {
        // didFinishLaunchWithOptions equivalent
        print("App init")
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                SecondView()
                    .onOpenURL { url in
                        // Handling Deeplinks
                        print("Incoming Deeplink URL: \(url)")
                    }
                    .ignoresSafeArea(.all, edges: .top)
            }
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .active:
                // applicationDidBecomeActive
                print("onChange: ScenePhase: App Active")
                break
            case .background:
                // applicationDidEnterBackground
                print("onChange: ScenePhase: App Background")
                break
            case .inactive:
                // applicationWillResignActive
                print("onChange: ScenePhase: App Inactive")
                break
            @unknown default:
                fatalError("Not handled")
            }
        }
    }
}
