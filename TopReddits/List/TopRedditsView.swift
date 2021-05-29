//
//  TopRedditsView.swift
//  TopReddits
//
//  Created by Raphael Braun on 29/05/21.
//

import UIKit

final class TopRedditsView: BaseView {
  let tableView: UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = .systemFill
    tableView.separatorStyle = .none
    tableView.register(TopRedditsTableViewCell.self, forCellReuseIdentifier: TopRedditsTableViewCell.identifier)
    tableView.estimatedRowHeight = 200
    tableView.rowHeight = UITableView.automaticDimension
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()
  let footerViewActivityIndicatorView: UIActivityIndicatorView = {
    let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    activityIndicator.hidesWhenStopped = true
    return activityIndicator
  }()

  //MARK: - Initialize

  override func initialize() {
    backgroundColor = .white
    tableView.tableFooterView = footerViewActivityIndicatorView

    addSubview(tableView)
  }

  //MARK: - Constraints

  override func installConstraints() {
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: topAnchor),
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}
