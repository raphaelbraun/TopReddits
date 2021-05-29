//
//  AppCoordinator.swift
//  TopReddits
//
//  Created by Raphael Braun on 29/05/21.
//

import UIKit

class AppCoordinator: Coordinator {
  var childCoordinators = [Coordinator]()
  var navigationController: UINavigationController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    
  }
}
