//
//  AppDelegate.swift
//  ExampleApp
//
//  Copyright © 2019 DreamTeam Apps. All rights reserved.
//

import UIKit
import Guise
import DT_Core_iOS

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private func updateRootViewController() {
        let router: RouterProtocol = Guise.resolve()!
        let viCo = router.get(vmType: MainViewModel.self, initObj: MainInitObject())
        changeRootViewController(to: viCo)
    }
    
    private func changeRootViewController(to vc: UIViewController) {
        if let window = UIApplication.shared.keyWindow {
            window.rootViewController = vc
        } else {
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = vc
            window.makeKeyAndVisible()
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        App.registerAppDependencies()
        
        updateRootViewController()
        
        return true
    }


}

