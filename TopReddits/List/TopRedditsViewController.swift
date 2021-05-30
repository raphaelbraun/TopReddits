//
//  TopRedditsViewController.swift
//  TopReddits
//
//  Created by Raphael Braun on 29/05/21.
//

import UIKit

final class TopRedditsViewController: UIViewController {
  private(set) lazy var baseView: TopRedditsView = {
    let view = TopRedditsView()
    return view
  }()
  let viewModel: TopRedditsViewModelProtocol

  init(viewModel: TopRedditsViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: .main)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Life Cycle

  override func loadView() {
    super.loadView()

    view = baseView
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setupBinds()
    configNavigationBar()
  }

  private func setupBinds() {
    title = viewModel.navigationTitle
    baseView.tableView.dataSource = viewModel.tableDataSource
    baseView.tableView.delegate = self
    baseView.refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)

    viewModel.reloadData = { [weak self] in
      DispatchQueue.main.async {
        guard let self = self else { return }
        self.baseView.tableView.reloadData()
        self.baseView.footerViewActivityIndicatorView.stopAnimating()
        if self.baseView.refreshControl.isRefreshing {
          self.baseView.refreshControl.endRefreshing()
        }
      }
    }

    viewModel.error = { [weak self] error in
      DispatchQueue.main.async {
        guard let self = self else { return }
        self.baseView.tableViewActivityIndicatorView.stopAnimating()
        self.baseView.errorLabel.text = error.localizedDescription
        if self.baseView.refreshControl.isRefreshing {
          self.baseView.refreshControl.endRefreshing()
        }
        self.baseView.tableView.reloadData()
      }
    }
  }

  @objc func refreshData() {
    viewModel.getReddits()
  }
}

private extension TopRedditsViewController {
  func configNavigationBar() {
    navigationController?.navigationBar.isTranslucent = false
    let redditLogo = UIBarButtonItem(image: UIImage(named: "reddit_logo"), style: .plain, target: nil, action: nil)
    navigationItem.leftBarButtonItem = redditLogo
  }
}

extension TopRedditsViewController: UIScrollViewDelegate, UITableViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offsetY = scrollView.contentOffset.y
    let contentHeight = scrollView.contentSize.height
    if offsetY > contentHeight - scrollView.frame.height, !viewModel.isLoading {
      baseView.footerViewActivityIndicatorView.startAnimating()
      viewModel.loadMore()
    }
  }
}
