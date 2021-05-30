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
    titleLabel.numberOfLines = 3
    titleLabel.font = .preferredFont(forTextStyle: .headline)
    titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    return titleLabel
  }()
  let subredditLabel: UILabel = {
    let subredditLabel = UILabel()
    subredditLabel.font = .preferredFont(forTextStyle: .caption1)
    subredditLabel.textColor = UIColor.init(named: "AccentColor")
    subredditLabel.setContentHuggingPriority(.required, for: .vertical)
    return subredditLabel
  }()
  let authorLabel: UILabel = {
    let authorLabel = UILabel()
    authorLabel.font = .preferredFont(forTextStyle: .caption2)
    authorLabel.textColor = .gray
    authorLabel.adjustsFontSizeToFitWidth = true
    authorLabel.minimumScaleFactor = 0.6
    authorLabel.setContentHuggingPriority(.required, for: .vertical)
    return authorLabel
  }()
  let thumbnailImageView: ThumbnailLoaderImageView = {
    let thumbnailImageView = ThumbnailLoaderImageView()
    thumbnailImageView.contentMode = .scaleAspectFit
    return thumbnailImageView
  }()
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
    let stackView = UIStackView(arrangedSubviews: [upVotesStackView, numCommentsStackView, createdAtStackView, UIView()])
    stackView.spacing = 6
    stackView.alignment = .leading
    return stackView
  }()
  private lazy var subredditAndAuthorNameStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [subredditLabel, UIView(), authorLabel])
    return stackView
  }()
  private lazy var mainStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [titleLabel, subredditAndAuthorNameStackView, thumbnailImageView, postDataStackView])
    stackView.axis = .vertical
    stackView.spacing = 12
    stackView.setCustomSpacing(4, after: titleLabel)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  private weak var heightConstraint: NSLayoutConstraint?

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

  func setupConstraints(thumbnailHeight: Int?) {
    if let thumbnailHeight = thumbnailHeight {
      heightConstraint = thumbnailImageView.heightAnchor.constraint(equalToConstant: CGFloat(thumbnailHeight)*1.5)
      heightConstraint?.priority = .defaultLow
      heightConstraint?.isActive = true
    } else {
      thumbnailImageView.isHidden = true
      titleLabel.numberOfLines = 0
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
    ])
  }

  override func prepareForReuse() {
    super.prepareForReuse()

    guard let heightConstraint = heightConstraint else { return }
    thumbnailImageView.removeConstraint(heightConstraint)
  }
}
