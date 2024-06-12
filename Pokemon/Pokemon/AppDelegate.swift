//
//  AppDelegate.swift
//  Pokemon
//
//  Created by Scizor on 4/25/24.
//

import UIKit
import Coordinator

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private let coordinator = FeatureListCoordinator()

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        coordinator.setupForPresentation()
        window!.rootViewController = coordinator.router.navigationController
        window!.makeKeyAndVisible()
        return true
    }
}

