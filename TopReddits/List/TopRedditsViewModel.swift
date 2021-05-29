//
//  TopRedditsViewModel.swift
//  TopReddits
//
//  Created by Raphael Braun on 29/05/21.
//

import UIKit

protocol TopRedditsNavigationDelegate: AnyObject {

}

protocol TopRedditsViewModelProtocol: AnyObject {
  var navigationTitle: String { get }
}

final class TopRedditsViewModel {
  private weak var navigationDelegate: TopRedditsNavigationDelegate?
  let navigationTitle: String

  init(navigationDelegate: TopRedditsNavigationDelegate? = nil) {
    self.navigationDelegate = navigationDelegate
    self.navigationTitle = "Top"
  }
}

//MARK: - TopRedditsSegurosViewModelProtocol

extension TopRedditsViewModel: TopRedditsViewModelProtocol { }
