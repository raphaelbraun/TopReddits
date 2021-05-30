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
    cell.createdAtLabel.text = formatDate(model.createdUtc)
    cell.numCommnetsLabel.text = model.numComments.roundedWithAbbreviations
    cell.upsLabel.text = model.ups.roundedWithAbbreviations
    cell.setupConstraints(thumbnailHeight: model.thumbnailHeight)
    cell.thumbnailImageView.loadThumbnail(from: model.thumbnail)
  }

  func formatDate(_ createdUtc: Date) -> String {
    let dateFormatter = RelativeDateTimeFormatter()
    dateFormatter.dateTimeStyle = .named
    return dateFormatter.localizedString(for: createdUtc, relativeTo: Date())
  }
}
