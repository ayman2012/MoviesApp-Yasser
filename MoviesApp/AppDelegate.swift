//
//  AppDelegate.swift
//  MoviesApp
//
//  Created by Ayman Fathy on 27/04/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = TrendingMoviesListViewController()
        window.makeKeyAndVisible()
        return true
    }

}

