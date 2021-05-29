//
//  TableViewDataSource.swift
//  TopReddits
//
//  Created by Raphael Braun on 29/05/21.
//

import UIKit

class TableViewDataSource<Model>: NSObject, UITableViewDataSource {
  typealias CellConfigurator = (UITableViewCell, Model) -> Void

  var models: [Model]
  private let reuseIdentifier: String
  private let cellConfigurator: CellConfigurator

  init(models: [Model],
       reuseIdentifier: String,
       cellConfigurator: @escaping CellConfigurator) {
    self.models = models
    self.reuseIdentifier = reuseIdentifier
    self.cellConfigurator = cellConfigurator
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    models.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let model = models[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

    cellConfigurator(cell, model)

    return cell
  }
}

extension TableViewDataSource {
  func getModel(at indexPath: IndexPath) -> Model? {
    guard models.indices.contains(indexPath.row) else {
      return nil
    }
    return models[indexPath.row]
  }
}
