//
//  TopRedditsWorker.swift
//  TopReddits
//
//  Created by Raphael Braun on 29/05/21.
//

import Foundation

protocol TopRedditsWorkerProtocol: AnyObject {
  func fetchReddits(after: String?, completion: @escaping (Result<TopReddits, Error>) -> Void)
}

class TopRedditsWorker {
  private var service: NetworkRequestable

  init(service: NetworkRequestable = NetworkService(host: Constants.Networking.baseURL)) {
    self.service = service
  }
}

//MARK: - TopRedditsWorkerProtocol

extension TopRedditsWorker: TopRedditsWorkerProtocol {
  public func fetchReddits(after: String?, completion: @escaping (Result<TopReddits, Error>) -> Void) {
    var endpoint = Endpoint(path: Constants.Networking.TopReddits.top)
    if let after = after {
      endpoint.queryItems = [URLQueryItem(name: "after", value: after)]
    }
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    decoder.dateDecodingStrategy = .secondsSince1970

    service.request(for: endpoint, decoder: decoder, completion: completion)
  }
}
