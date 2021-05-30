//
//  ThumbnailLoaderImageView.swift
//  TopReddits
//
//  Created by Raphael Braun on 29/05/21.
//

import UIKit

final class ThumbnailLoaderImageView: UIImageView {
  var task: URLSessionDataTask!

  func loadThumbnail(from url: String) {
    image = nil

    if let task = task {
      task.cancel()
    }

    if url == Constants.DefaultThumbnails.nsfw {
      DispatchQueue.main.async {
        self.image = UIImage(systemName: "eye.slash")
      }
    } else if url == Constants.DefaultThumbnails.default {
      DispatchQueue.main.async {
        self.image = UIImage(systemName: "link")
      }
    }

    guard let url = URL(string: url), url.absoluteString.contains(".jpg") || url.absoluteString.contains(".png") else { return }
    task = URLSession.shared.dataTask(with: url) { (data, response, error) in
      guard let data = data, let thumbnail = UIImage(data: data) else { return }

      DispatchQueue.main.async {
        self.image = thumbnail
      }
    }

    task.resume()
  }
}
