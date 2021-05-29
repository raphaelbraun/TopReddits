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
  private var service: TopRedditsWorkerProtocol

  let navigationTitle: String

  init(service: TopRedditsWorkerProtocol = TopRedditsWorker(),
    navigationDelegate: TopRedditsNavigationDelegate? = nil) {
    self.service = service
    self.navigationDelegate = navigationDelegate
    self.navigationTitle = "Top"

    getReddits()
  }
}

//MARK: - TopRedditsSegurosViewModelProtocol

extension TopRedditsViewModel: TopRedditsViewModelProtocol {
  func getReddits() {
    service.fetchReddits(after: nil) { result in
      switch result {
        case .success(let topReddits):
          print(topReddits)
        case .failure(let error):
          print(error)
      }
    }
  }
}
