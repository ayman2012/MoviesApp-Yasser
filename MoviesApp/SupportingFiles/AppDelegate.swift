//
//  AppDelegate.swift
//  MoviesApp
//
//  Created by Ayman Fathy on 27/04/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        handleNavigationBarStyle()
        window = UIWindow(frame: UIScreen.main.bounds)
        _ = AppNavigator(window: window ?? UIWindow())
        return true
    }
}

private func handleNavigationBarStyle() {
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
