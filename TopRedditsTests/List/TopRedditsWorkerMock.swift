//
//  TopRedditsWorkerMock.swift
//  TopRedditsTests
//
//  Created by Raphael Braun on 30/05/21.
//

import Foundation
@testable import TopReddits

class TopRedditsWorkerSuccessMock: TopRedditsWorkerProtocol, JsonLoader {
  func fetchReddits(after: String?, completion: @escaping (Result<TopReddits, Error>) -> Void) {
    guard let top: TopReddits = loadJson(filename: "top",
                                           dateDecodingStrategy: .secondsSince1970,
                                           keyDecodingStrategy: .convertFromSnakeCase)
    else { return }
    completion(.success(top))
  }
}

class TopRedditsWorkerFailureMock: TopRedditsWorkerProtocol, JsonLoader {
  func fetchReddits(after: String?, completion: @escaping (Result<TopReddits, Error>) -> Void) {
    completion(.failure(NSError()))
  }
}

