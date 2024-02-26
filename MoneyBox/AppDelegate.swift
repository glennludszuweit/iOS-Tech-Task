//
//  AppDelegate.swift
//  MoneyBox
//
//  Created by Zeynep Kara on 15.01.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let viewModel = LoginViewModel()
        let navigationController = UINavigationController(rootViewController: LoginViewController(viewModel: viewModel))
        
        window = UIWindow()
        
        if let window {
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
            return true
        } else {
            return false
        }
    }
}

