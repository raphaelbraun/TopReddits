//
//  Array+Extension.swift
//  TopReddits
//
//  Created by Raphael Braun on 30/05/21.
//

import Foundation

extension Array where Element == Award {
  func chunks(_ chunkSize: Int) -> [[Element]] {
    return stride(from: 0, to: self.count, by: chunkSize).map {
      Array(self[$0..<Swift.min($0 + chunkSize, self.count)])
    }
  }
}
