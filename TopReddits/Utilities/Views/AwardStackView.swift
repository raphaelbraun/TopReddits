//
//  AwardingsStackView.swift
//  TopReddits
//
//  Created by Raphael Braun on 30/05/21.
//

import UIKit

final class AwardStackView: UIStackView {
  let thumbnailImageView: LoaderImageView = {
    let thumbnailImageView = LoaderImageView()
    thumbnailImageView.contentMode = .scaleAspectFit
    return thumbnailImageView
  }()
  let awardCountLabel: UILabel = {
    let upsLabel = UILabel()
    upsLabel.font = .preferredFont(forTextStyle: .footnote)
    upsLabel.textColor = .lightGray
    return upsLabel
  }()

  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  init(_ award: Award) {
    super.init(frame: .zero)

    spacing = 2

    addArrangedSubview(thumbnailImageView)
    addArrangedSubview(awardCountLabel)
    translatesAutoresizingMaskIntoConstraints = false
    awardCountLabel.text = award.count.description
    guard let url = award.resizedStaticIcons.first?.url else { return }
    let urlWithoutAmp = url.replacingOccurrences(of: "amp;", with: "")
    thumbnailImageView.loadThumbnail(from: urlWithoutAmp)
    setupConstraints()
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      thumbnailImageView.heightAnchor.constraint(equalToConstant: 16),
      thumbnailImageView.widthAnchor.constraint(equalToConstant: 16)
    ])
  }
}

final class AwardingsStackView: UIStackView {
  init() {
    super.init(frame: .zero)
    spacing = 8
    alignment = .leading
    axis = .vertical
    translatesAutoresizingMaskIntoConstraints = false
  }

  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configView(_ awards: [Award]) {
    let splitAwards = awards.chunks(8)

    for chunk in splitAwards {
      let stackView = UIStackView()
      stackView.spacing = 8
      addArrangedSubview(stackView)
      for award in chunk {
        stackView.addArrangedSubview(AwardStackView(award))
      }
    }
  }
}
