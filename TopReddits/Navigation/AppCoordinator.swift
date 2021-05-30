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
    let viewModel = TopRedditsViewModel(navigationDelegate: self)
    let viewController = TopRedditsViewController(viewModel: viewModel)

    navigationController.pushViewController(viewController, animated: false)
  }
}

// MARK: - TopRedditsNavigationDelegate

extension AppCoordinator: TopRedditsNavigationDelegate {
  func openReddit(_ reddit: ChildData) {
    let viewModel = TopRedditsDetailViewModel(reddit: reddit, navigationDelegate: self)
    let viewController = TopRedditsDetailViewController(viewModel: viewModel)

    navigationController.pushViewController(viewController, animated: false)
  }
}

// MARK: - TopRedditsDetailNavigationDelegate

extension AppCoordinator: TopRedditsDetailNavigationDelegate {
  func presentAlert(error: Error?) {
    if let error = error {
      let alertController = UIAlertController(title: "There was an error saving the image", message: error.localizedDescription, preferredStyle: .alert)
      alertController.addAction(UIAlertAction(title: "OK", style: .default))
      navigationController.present(alertController, animated: true)
    } else {
      let alertController = UIAlertController(title: "Saved", message: "Your image has been saved to your photos", preferredStyle: .alert)
      alertController.addAction(UIAlertAction(title: "OK", style: .default))
      navigationController.present(alertController, animated: true)
    }
  }
}
