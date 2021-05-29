//
//  Coordinator.swift
//  TopReddits
//
//  Created by Raphael Braun on 29/05/21.
//

import UIKit

protocol Coordinator: AnyObject {
  var childCoordinators: [Coordinator] { get set }
  var navigationController: UINavigationController { get set }

  func start()
}

extension Coordinator {
  @discardableResult func addChildCoordinator(_ childCoordinator: Coordinator) -> Coordinator {
    self.childCoordinators.append(childCoordinator)
    return childCoordinator
  }

  @discardableResult func removeChildCoordinator(_ childCoordinator: Coordinator) -> Coordinator {
    self.childCoordinators = self.childCoordinators.filter { $0 !== childCoordinator }
    return childCoordinator
  }
}

protocol CoordinatorDelegate: AnyObject {
  func didClose(childCoordinator: Coordinator)
}

