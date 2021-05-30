//
//  URL+Extension.swift
//  TopReddits
//
//  Created by Raphael Braun on 29/05/21.
//

import Foundation

extension URL {
  init(with staticString: StaticString) {
    guard let url = URL(string: "\(staticString)") else {
      preconditionFailure("Invalid static URL string: \(staticString)")
    }
    self = url
  }
}
