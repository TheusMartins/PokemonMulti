//
//  AppDelegate.swift
//  Pokemon SwiftUI
//
//  Created by Scizor on 6/12/24.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller = FeatureListController()
        let navigation = UINavigationController(rootViewController: controller)
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = navigation
        window!.makeKeyAndVisible()
        return true
    }
}



