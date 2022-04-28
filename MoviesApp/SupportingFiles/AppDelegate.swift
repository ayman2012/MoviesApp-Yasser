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
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewModel = TrendingMoviesListViewModel()
        window?.rootViewController = TrendingMoviesListViewController.init(with: viewModel)
        window?.makeKeyAndVisible()
        return true
    }
}

