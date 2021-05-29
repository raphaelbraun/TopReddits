//
//  TopRedditsTableViewCell.swift
//  TopReddits
//
//  Created by Raphael Braun on 29/05/21.
//

import UIKit

final class TopRedditsTableViewCell: UITableViewCell {
  static let identifier = "TopRedditsTableViewCell"
  let titleLabel: UILabel = {
    let titleLabel = UILabel()
    titleLabel.numberOfLines = 2
    titleLabel.font = .preferredFont(forTextStyle: .headline)
    titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    return titleLabel
  }()
  let subredditLabel: UILabel = {
    let titleLabel = UILabel()
    titleLabel.font = .preferredFont(forTextStyle: .caption1)
    titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    titleLabel.text = "Post Title can be loooooong or short it muts break lines but 2 at max pls no longer than that"
    return titleLabel
  }()
  let thumbnailImageView: ThumbnailLoaderImageView = {
    let thumbnailImageView = ThumbnailLoaderImageView()
    thumbnailImageView.contentMode = .scaleAspectFit
    thumbnailImageView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
    thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
    return thumbnailImageView
  }()
  let authorLabel: UILabel = {
    let authorLabel = UILabel()
    authorLabel.textColor = .black
    authorLabel.font = .preferredFont(forTextStyle: .subheadline)
    authorLabel.text = "Author name"
    return authorLabel
  }()
  let upsImageView: UIImageView = {
    let upsImageView = UIImageView(image: UIImage(systemName: "arrow.up.circle"))
    return upsImageView
  }()
  let upsLabel: UILabel = {
    let upsLabel = UILabel()
    upsLabel.textColor = .black
    upsLabel.font = .preferredFont(forTextStyle: .footnote)
    upsLabel.text = "11.456"
    return upsLabel
  }()
  let numCommnetsImageView: UIImageView = {
    let upsImageView = UIImageView(image: UIImage(systemName: "text.bubble"))
    return upsImageView
  }()
  let numCommnetsLabel: UILabel = {
    let numCommentsLabel = UILabel()
    numCommentsLabel.textColor = .black
    numCommentsLabel.font = .preferredFont(forTextStyle: .footnote)
    numCommentsLabel.text = "124"
    return numCommentsLabel
  }()
  let createdAtImageView: UIImageView = {
    let createdAtImageView = UIImageView(image: UIImage(systemName: "clock"))
    return createdAtImageView
  }()
  let createdAtLabel: UILabel = {
    let createdAtLabel = UILabel()
    createdAtLabel.textColor = .black
    createdAtLabel.font = .preferredFont(forTextStyle: .footnote)
    createdAtLabel.text = "2h"
    return createdAtLabel
  }()
  let spacerView: UIView = {
    let view = UIView()
    view.backgroundColor = .systemFill
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  private lazy var upVotesStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [upsImageView, upsLabel])
    stackView.spacing = 2
    return stackView
  }()
  private lazy var numCommentsStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [numCommnetsImageView, numCommnetsLabel])
    stackView.spacing = 2
    return stackView
  }()
  private lazy var createdAtStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [createdAtImageView, createdAtLabel])
    stackView.spacing = 2
    return stackView
  }()
  private lazy var postDataStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [upVotesStackView, numCommentsStackView, createdAtStackView])
    stackView.spacing = 6
    stackView.alignment = .leading
    return stackView
  }()
  private lazy var postDataAndAuthorStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [postDataStackView, UIView(), authorLabel])
    stackView.spacing = 6
    return stackView
  }()
  private lazy var mainStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [titleLabel, subredditLabel, thumbnailImageView, postDataAndAuthorStackView])
    stackView.axis = .vertical
    stackView.spacing = 12
    stackView.setCustomSpacing(4, after: titleLabel)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  private var heightConstraint: NSLayoutConstraint!

  //MARK: - Init

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - SetupLayout

  private func setupLayout() {
    selectionStyle = .none
    contentView.addSubview(mainStackView)
    contentView.addSubview(spacerView)
  }

  //MARK: - SetupConstraints

  func setupConstraints(thumbnailHeight: CGFloat?) {
    if let thumbnailHeight = thumbnailHeight {
      heightConstraint = thumbnailImageView.heightAnchor.constraint(equalToConstant: thumbnailHeight*1.5)
      heightConstraint.priority = .defaultLow
    } else {
      thumbnailImageView.isHidden = true
    }
    NSLayoutConstraint.activate([
      mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
      mainStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
      mainStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),

      spacerView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 14),
      spacerView.leadingAnchor.constraint(equalTo: leadingAnchor),
      spacerView.trailingAnchor.constraint(equalTo: trailingAnchor),
      spacerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      spacerView.heightAnchor.constraint(equalToConstant: 12),
      heightConstraint
    ])
  }

  override func prepareForReuse() {
    super.prepareForReuse()

    thumbnailImageView.removeConstraint(heightConstraint)
  }
}

