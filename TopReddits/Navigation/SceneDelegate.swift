//
//  SceneDelegate.swift
//  TopReddits
//
//  Created by Raphael Braun on 29/05/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  var coordinator: AppCoordinator?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }

    let navigationController = UINavigationController()

    coordinator = AppCoordinator(navigationController: navigationController)

    coordinator?.start()

    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
  }
}
