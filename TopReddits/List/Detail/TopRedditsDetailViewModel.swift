//
//  TopRedditsDetailViewModel.swift
//  TopReddits
//
//  Created by Raphael Braun on 30/05/21.
//

import UIKit

protocol TopRedditsDetailNavigationDelegate: AnyObject {
  func presentAlert(error: Error?)
}

protocol TopRedditsDetailViewModelProtocol: AnyObject {
  var navigationTitle: String { get }
  var reddit: ChildData { get }

  func saveToLibrary(error: Error?)
}

class TopRedditsDetailViewModel {
  private weak var navigationDelegate: TopRedditsDetailNavigationDelegate?

  let navigationTitle: String
  let reddit: ChildData

  init(reddit: ChildData,
       navigationDelegate: TopRedditsDetailNavigationDelegate? = nil) {
    self.navigationDelegate = navigationDelegate
    self.reddit = reddit
    self.navigationTitle = "u/\(reddit.author)"
  }
}

//MARK: - TopRedditsDetailViewModelProtocol

extension TopRedditsDetailViewModel: TopRedditsDetailViewModelProtocol {
  func saveToLibrary(error: Error?) {
    navigationDelegate?.presentAlert(error: error)
  }
}
