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
  var tableDataSource: TableViewDataSource<TopRedditsCellViewModel> { get }
  var navigationTitle: String { get }
  var reloadData: (() -> Void)? { get set }

  func getReddits()
}

final class TopRedditsViewModel {
  private weak var navigationDelegate: TopRedditsNavigationDelegate?
  private var service: TopRedditsWorkerProtocol
  var tableDataSource: TableViewDataSource<TopRedditsCellViewModel> = .make(for: [])
  var reloadData: (() -> Void)?

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
          self.tableDataSource.models = topReddits.data.children.map { TopRedditsCellViewModel(model: $0.data) }
        case .failure(let error):
          print("error")
      }
      self.reloadData?()
    }
  }
}

extension TableViewDataSource where Model == TopRedditsCellViewModel {
  static func make(for models: [TopRedditsCellViewModel], reuseIdentifier: String = TopRedditsTableViewCell.identifier) -> TableViewDataSource<Model> {
    TableViewDataSource(models: models, reuseIdentifier: reuseIdentifier) { (cell, model) in
      if let cell = cell as? TopRedditsTableViewCell {
        model.configure(cell: cell)
      }
    }
  }
}
