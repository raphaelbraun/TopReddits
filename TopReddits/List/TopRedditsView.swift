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

    tableView.estimatedRowHeight = 200
    tableView.rowHeight = UITableView.automaticDimension
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()

  //MARK: - Initialize

  override func initialize() {
    backgroundColor = .white

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
