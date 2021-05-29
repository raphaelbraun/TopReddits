//
//  Service.swift
//  TopReddits
//
//  Created by Raphael Braun on 29/05/21.
//

import Foundation

enum NetworkError: LocalizedError, Equatable {
  case notConnectedToInternet
  case cancelled
  case timedOut
  case generic(Error?)
  case emptyData
  case invalidEndpointError
  case serverSideError(ServerSideError)

  var errorDescription: String? {
    switch self {
      case .serverSideError(let serverSideError): return serverSideError.defaultError?.localizedDescription
      case .notConnectedToInternet: return "Internet Connection appears to be offline"
      case .cancelled: return "The operation was canceled"
      case .timedOut: return "Request Timeout"
      case .generic(let error): return "The operation couldn't be completed. \(error?.localizedDescription ?? "")"
      case .emptyData: return "The data couldn’t be read because it is missing"
      case .invalidEndpointError: return "Invalid endpoint"
    }
  }

  static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
    switch (lhs, rhs) {
      case (.notConnectedToInternet, .notConnectedToInternet): return true
      case (.cancelled, .cancelled): return true
      case (.emptyData, .emptyData): return true
      case (.invalidEndpointError, .invalidEndpointError): return true
      case (.generic, .generic): return true
      case let (.serverSideError(lhsError), .serverSideError(rhsError)): return lhsError == rhsError

      default: return false
    }
  }
}

struct ServerSideError: Equatable {
  let statusCode: Int
  let request: URLRequest
  let response: HTTPURLResponse?
  let data: Data?
  let defaultError: Error?

  static func == (lhs: ServerSideError, rhs: ServerSideError) -> Bool {
    lhs.statusCode == rhs.statusCode && lhs.request == rhs.request
  }

  init(statusCode: Int,
       request: URLRequest,
       response: HTTPURLResponse?,
       data: Data?,
       defaultError: Error?) {
    self.statusCode = statusCode
    self.request = request
    self.response = response
    self.data = data
    self.defaultError = defaultError
  }
}

// MARK: - NetworkRequestable

protocol NetworkRequestable: AnyObject {
  var urlSession: URLSession { get }
  var host: URL { get }

  @discardableResult
  func request<R: Decodable>(for endpoint: Endpoint, decoder: JSONDecoder, completion: @escaping (Result<R, Error>) -> Void) -> URLSessionDataTask?

  @discardableResult
  func dataTask(for endpoint: Endpoint, completion: @escaping ((Result<Data, Error>) -> Void)) -> URLSessionDataTask?
}

// MARK: - NetworkService

class NetworkService {
  let urlSession: URLSession
  let host: URL

  init(host: URL, urlSession: URLSession = URLSession.shared) {
    self.host = host
    self.urlSession = urlSession
  }
}

extension NetworkService: NetworkRequestable {
  func request<R: Decodable>(for endpoint: Endpoint,
                             decoder: JSONDecoder = .init(),
                             completion: @escaping (Result<R, Error>) -> Void) -> URLSessionDataTask? {
    guard let request = endpoint.makeRequest(baseURL: host) else {
      completion(.failure(NetworkError.invalidEndpointError))
      return nil
    }

    return dataTask(for: endpoint) { result in
      switch result {
        case let .success(data):
          do {
            let object = try decoder.decode(R.self, from: data)
            completion(.success(object))
          } catch {
            let serverError = ServerSideError(statusCode: 200,
                                              request: request,
                                              response: nil,
                                              data: data,
                                              defaultError: error)
            completion(.failure(NetworkError.serverSideError(serverError)))
          }
        case let .failure(error):
          completion(.failure(error))
      }
    }
  }

  func dataTask(for endpoint: Endpoint,
                completion: @escaping ((Result<Data, Error>) -> Void)) -> URLSessionDataTask? {
    guard let request = endpoint.makeRequest(baseURL: host) else {
      completion(.failure(NetworkError.invalidEndpointError))
      return nil
    }

    let task = urlSession.dataTask(with: request) { (data, response, error) in
      if let error = error {
        if let urlError = error as? URLError {
          switch urlError.code {
            case .notConnectedToInternet: return completion(.failure(NetworkError.notConnectedToInternet))
            case .cancelled: return completion(.failure(NetworkError.cancelled))
            case .timedOut: return completion(.failure(NetworkError.timedOut))
            default: return completion(.failure(NetworkError.generic(urlError)))
          }
        } else {
          completion(.failure(NetworkError.generic(error)))
        }
      } else if let response = response as? HTTPURLResponse,
                let status = response.status {

        guard status.responseType == .success else {
          let serverError = ServerSideError(statusCode: status.rawValue,
                                            request: request,
                                            response: response,
                                            data: data,
                                            defaultError: nil)
          completion(.failure(NetworkError.serverSideError(serverError)))
          return
        }

        if let data = data {
          completion(.success(data))
        } else {
          completion(.failure(NetworkError.emptyData))
        }
      } else {
        completion(.failure(NetworkError.generic(nil)))
      }
    }
    task.resume()
    return task
  }
}
