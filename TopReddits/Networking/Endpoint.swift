//
//  Endpoint.swift
//  TopReddits
//
//  Created by Raphael Braun on 29/05/21.
//

import Foundation

struct Endpoint {
  let path: String
  var method: Method = .get
  var queryItems = [URLQueryItem]()
  var bodyParameters = [String: Any]()

  enum Method: String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
  }

  init(path: String,
       method: Method = .get,
       queryItems: [URLQueryItem] = [],
       bodyParameters: [String: Any] = [:]) {
    self.path = path
    self.method = method
    self.queryItems = queryItems
    self.bodyParameters = bodyParameters
  }
}

extension Endpoint {
  func makeRequest(baseURL: URL) -> URLRequest? {
    guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else { return nil }
    components.path += path
    components.queryItems = queryItems.isEmpty ? nil : queryItems

    guard let url = components.url else { return nil }

    var request = URLRequest(url: url)
    configRequest(&request)
    return request
  }
}

private extension Endpoint {
  var shouldAddBodyToRequest: Bool {
    return method == .post || method == .put || method == .patch
  }

  func configRequest(_ request: inout URLRequest) {
    request.httpMethod = method.rawValue

    if shouldAddBodyToRequest,
       let httpBody = try? JSONSerialization.data(withJSONObject: bodyParameters, options: []) {
      request.httpBody = httpBody
    }
  }
}
