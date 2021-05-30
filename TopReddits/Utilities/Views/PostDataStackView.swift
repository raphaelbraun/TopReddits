//
//  PostDataStackView.swift
//  TopReddits
//
//  Created by Raphael Braun on 30/05/21.
//

import UIKit

final class PostDataStackView: UIStackView {
  let upsImageView: UIImageView = {
    let upsImageView = UIImageView(image: UIImage(systemName: "arrow.up.circle"))
    upsImageView.tintColor = .lightGray
    return upsImageView
  }()
  let upsLabel: UILabel = {
    let upsLabel = UILabel()
    upsLabel.font = .preferredFont(forTextStyle: .footnote)
    upsLabel.textColor = .lightGray
    return upsLabel
  }()
  let numCommnetsImageView: UIImageView = {
    let numCommnetsImageView = UIImageView(image: UIImage(systemName: "bubble.right"))
    numCommnetsImageView.tintColor = .lightGray
    return numCommnetsImageView
  }()
  let numCommnetsLabel: UILabel = {
    let numCommentsLabel = UILabel()
    numCommentsLabel.font = .preferredFont(forTextStyle: .footnote)
    numCommentsLabel.textColor = .lightGray
    return numCommentsLabel
  }()
  let createdAtImageView: UIImageView = {
    let createdAtImageView = UIImageView(image: UIImage(systemName: "clock"))
    createdAtImageView.tintColor = .lightGray
    return createdAtImageView
  }()
  let createdAtLabel: UILabel = {
    let createdAtLabel = UILabel()
    createdAtLabel.font = .preferredFont(forTextStyle: .footnote)
    createdAtLabel.textColor = .lightGray
    return createdAtLabel
  }()
  lazy var upVotesStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [upsImageView, upsLabel])
    stackView.spacing = 2
    return stackView
  }()
  lazy var numCommentsStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [numCommnetsImageView, numCommnetsLabel])
    stackView.spacing = 2
    return stackView
  }()
  lazy var createdAtStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [createdAtImageView, createdAtLabel])
    stackView.spacing = 2
    return stackView
  }()

  init() {
    super.init(frame: .zero)

    spacing = 6

    alignment = .leading

    addArrangedSubview(upVotesStackView)
    addArrangedSubview(numCommentsStackView)
    addArrangedSubview(createdAtStackView)
    addArrangedSubview(UIView())
  }

  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configView(_ model: ChildData) {
    upsLabel.text = model.ups.roundedWithAbbreviations
    numCommnetsLabel.text = model.numComments.roundedWithAbbreviations
    createdAtLabel.text = formatDate(model.createdUtc)
  }

  func formatDate(_ createdUtc: Date) -> String {
    let dateFormatter = RelativeDateTimeFormatter()
    dateFormatter.dateTimeStyle = .named
    return dateFormatter.localizedString(for: createdUtc, relativeTo: Date())
  }
}
