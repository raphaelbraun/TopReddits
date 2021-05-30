//
//  TopRedditsView.swift
//  TopReddits
//
//  Created by Raphael Braun on 29/05/21.
//

import UIKit

final class TopRedditsView: BaseView {
  let refreshControl = UIRefreshControl()
  let tableView: UITableView = {
    let tableView = UITableView()
    tableView.separatorStyle = .none
    tableView.register(TopRedditsTableViewCell.self, forCellReuseIdentifier: TopRedditsTableViewCell.identifier)
    tableView.estimatedRowHeight = 200
    tableView.rowHeight = UITableView.automaticDimension
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()
  let tableViewActivityIndicatorView: UIActivityIndicatorView = {
    let loader = UIActivityIndicatorView(style: .large)
    loader.hidesWhenStopped = true
    return loader
  }()
  let errorLabel: UILabel = {
    let errorLabel = UILabel()
    errorLabel.numberOfLines = 0
    errorLabel.font = .preferredFont(forTextStyle: .body)
    errorLabel.textAlignment = .center
    errorLabel.textColor = .gray
    return errorLabel
  }()
  lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [tableViewActivityIndicatorView, errorLabel])
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  let footerViewActivityIndicatorView: UIActivityIndicatorView = {
    let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    activityIndicator.hidesWhenStopped = true
    return activityIndicator
  }()

  //MARK: - Initialize

  override func initialize() {
    tableView.refreshControl = refreshControl
    tableView.tableFooterView = footerViewActivityIndicatorView
    tableView.backgroundView = stackView
    tableViewActivityIndicatorView.startAnimating()

    addSubview(tableView)
  }

  //MARK: - Constraints

  override func installConstraints() {
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: topAnchor),
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: bottomAnchor),

      stackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
      stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }
}
