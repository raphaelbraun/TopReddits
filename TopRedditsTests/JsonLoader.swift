//
//  JsonLoader.swift
//  TopRedditsTests
//
//  Created by Raphael Braun on 30/05/21.
//

import XCTest
@testable import TopReddits

protocol JsonLoader: AnyObject { }

extension JsonLoader {
  func loadJson<T: Decodable>(filename fileName: String,
                              inDirectory: String? = nil,
                              dateDecodingStrategy: JSONDecoder.DateDecodingStrategy? = nil,
                              keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy? = nil) -> T? {
    let bundle = Bundle.init(for: type(of: self))
    if let url = bundle.url(forResource: fileName, withExtension: "json") {
      do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        if let dateDecodingStrategy = dateDecodingStrategy {
          decoder.dateDecodingStrategy = dateDecodingStrategy
        }
        if let keyDecodingStrategy = keyDecodingStrategy {
          decoder.keyDecodingStrategy = keyDecodingStrategy
        }
        let jsonData = try decoder.decode(T.self, from: data)
        return jsonData
      } catch {
        print("error:\(error)")
      }
    }
    return nil
  }
}
