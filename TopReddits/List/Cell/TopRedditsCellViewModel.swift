//
//  TopRedditsCellViewModel.swift
//  TopReddits
//
//  Created by Raphael Braun on 29/05/21.
//

import UIKit

struct TopRedditsCellViewModel {
  let model: ChildData

  func configure(cell: TopRedditsTableViewCell) {
    let height = model.postHint == .some(.image) ? model.thumbnailHeight : 0
    cell.titleLabel.text = model.title
    cell.subredditLabel.text = model.subredditNamePrefixed
    cell.authorLabel.text = "u/\(model.author)"
    cell.setupConstraints(thumbnailHeight: height)
    cell.postDataStackView.configView(model)
    guard model.postHint == .some(.image) else {
      cell.thumbnailImageView.image = nil
      return
    }
    cell.thumbnailImageView.loadThumbnail(from: model.thumbnail)
  }
}
