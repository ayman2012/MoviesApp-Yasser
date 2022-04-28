//
//  AppNavigator.swift
//  MoviesApp
//
//  Created by Ayman Fathy on 28/04/2022.
//

import UIKit
final class AppNavigator {
    private static var rootController: UINavigationController!
    init(window: UIWindow) {
        AppNavigator.rootController = UINavigationController(rootViewController: Destination.moviesList.controller())
        window.rootViewController = AppNavigator.rootController
        window.makeKeyAndVisible()
    }

    init() throws {
        if AppNavigator.rootController == nil {
            throw NavigatorError.noRoot
        }
    }

    func present(_ dest: Destination) {
        AppNavigator.rootController.present(dest.controller(), animated: true, completion: nil)
    }
    func back() {
           AppNavigator.rootController.popViewController(animated: true)
       }
    func push(_ dest: Destination) {
        AppNavigator.rootController.pushViewController(dest.controller(), animated: true)
    }
}

enum NavigatorError: Error {
    case noRoot
}
