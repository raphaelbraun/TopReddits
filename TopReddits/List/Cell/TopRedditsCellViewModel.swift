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
    cell.titleLabel.text = model.title
    cell.subredditLabel.text = model.subredditNamePrefixed
    cell.authorLabel.text = "u/\(model.author)"
    cell.createdAtLabel.text = model.createdUtc.description
    cell.numCommnetsLabel.text = model.numComments.description
    cell.upsLabel.text = model.ups.description
    cell.setupConstraints(thumbnailHeight: CGFloat(model.thumbnailHeight!))
    cell.thumbnailImageView.loadThumbnail(from: model.thumbnail)
  }
}
