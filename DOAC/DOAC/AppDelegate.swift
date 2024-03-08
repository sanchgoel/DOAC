//
//  AppDelegate.swift
//  DOAC
//
//  Created by Sanchit Goel on 08/03/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let walkthroughVC = WalkthroughViewController()
        window?.rootViewController = UINavigationController.init(rootViewController: walkthroughVC)
        window?.makeKeyAndVisible()
        return true
    }
}
