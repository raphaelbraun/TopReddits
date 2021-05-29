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
  }
}

private extension TopRedditsViewController {
  func configNavigationBar() {
    navigationController?.navigationBar.isTranslucent = false
    let redditLogo = UIBarButtonItem(image: UIImage(named: "reddit_logo"), style: .plain, target: nil, action: nil)
    navigationItem.leftBarButtonItem = redditLogo
  }
}
