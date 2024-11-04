//
//  AppDelegate.swift
//  DemoTechnicalChallenge
//
//  Created by NeoSOFT on 04/11/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - UIWindow
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        return true
    }
    
    private func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootViewController = createRootViewController()
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
    
    private func createRootViewController() -> UINavigationController {
        let repositoriesViewController = RepositoriesViewController() // set your rootViewController here
        return UINavigationController(rootViewController: repositoriesViewController)
    }
}
