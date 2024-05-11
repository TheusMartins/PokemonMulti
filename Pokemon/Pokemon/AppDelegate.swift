//
//  AppDelegate.swift
//  Pokemon
//
//  Created by Scizor on 4/25/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let featureList = FeatureListController()
        window!.rootViewController = UINavigationController(rootViewController: featureList)
        window!.makeKeyAndVisible()
        return true
    }
}

