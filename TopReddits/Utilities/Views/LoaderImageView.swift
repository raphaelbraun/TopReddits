//
//  LoaderImageView.swift
//  TopReddits
//
//  Created by Raphael Braun on 29/05/21.
//

import UIKit

final class LoaderImageView: UIImageView {
  var task: URLSessionDataTask!
  let activityIndicatorView = UIActivityIndicatorView()

  func loadThumbnail(from url: String) {
    image = nil
    addActivityIndicator()

    if let task = task {
      task.cancel()
    }

    guard let url = URL(string: url) else { return }
    task = URLSession.shared.dataTask(with: url) { (data, response, error) in
      guard let data = data, let thumbnail = UIImage(data: data) else { return }

      DispatchQueue.main.async {
        self.image = thumbnail
        self.activityIndicatorView.stopAnimating()
      }
    }

    task.resume()
  }

  func addActivityIndicator() {
    activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(activityIndicatorView)

    NSLayoutConstraint.activate([
      activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
      activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
    ])

    activityIndicatorView.startAnimating()
  }
}
