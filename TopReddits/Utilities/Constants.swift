//
//  Constants.swift
//  TopReddits
//
//  Created by Raphael Braun on 29/05/21.
//

import Foundation

enum Constants {
  enum DefaultThumbnails {
    static let `default` = "default"
    static let nsfw = "nsfw"
    static let `self` = "self"
  }

  enum Networking {
    static let baseURL = URL(with: "https://www.reddit.com/")
    enum TopReddits {
      static let top = "top.json"
    }
  }
}
