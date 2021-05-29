//
//  SceneDelegate.swift
//  TopReddits
//
//  Created by Raphael Braun on 29/05/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?


  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }

    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = TopRedditsViewController()
    window?.makeKeyAndVisible()
  }
}
