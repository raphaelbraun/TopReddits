//
//  TopRedditsDetailView.swift
//  TopReddits
//
//  Created by Raphael Braun on 30/05/21.
//

import UIKit

final class TopRedditsDetailView: BaseView {
  let scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.backgroundColor = .systemGray6
    return scrollView
  }()
  let contentView: UIView = {
    let contentView = UIView()
    contentView.translatesAutoresizingMaskIntoConstraints = false
    return contentView
  }()
  let redditImageView: LoaderImageView = {
    let thumbnailImageView = LoaderImageView()
    thumbnailImageView.contentMode = .scaleAspectFit
    thumbnailImageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    return thumbnailImageView
  }()
  let titleLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .title1)
    label.textColor = .gray
    label.numberOfLines = 0
    return label
  }()
  var postDataStackView = PostDataStackView()
  var awardsStackView = AwardingsStackView()
  lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [redditImageView, titleLabel, postDataStackView, awardsStackView, saveRedditButton])
    stackView.axis = .vertical
    stackView.spacing = 16
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  let saveRedditButton: UIButton = {
    let button = UIButton()
    button.setTitle("Save in library", for: .normal)
    button.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
    return button
  }()

  //MARK: - Initialize

  override func initialize() {
    addSubview(scrollView)
    scrollView.addSubview(contentView)
    contentView.addSubview(stackView)
  }

  //MARK: - Constraints

  override func installConstraints() {
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: topAnchor),
      scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
      scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),

      contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

      redditImageView.heightAnchor.constraint(equalToConstant: 400),

      stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
      stackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
      stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }
}
