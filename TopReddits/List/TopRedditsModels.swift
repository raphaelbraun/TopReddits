//
//  TopRedditsModels.swift
//  TopReddits
//
//  Created by Raphael Braun on 29/05/21.
//

import Foundation

// MARK: - TopReddits
struct TopReddits: Decodable {
  let data: TopRedditsData
}

// MARK: - TopRedditsData
struct TopRedditsData: Decodable {
  let children: [Child]
  let after: String
}

// MARK: - Child
struct Child: Decodable {
  let data: ChildData
}

// MARK: - ChildData
struct ChildData: Decodable {
  let title: String
  let name: String
  let ups: Int
  let downs: Int
  let postHint: PostHint?
  let thumbnail: String
  let thumbnailHeight: Int?
  let subredditNamePrefixed: String
  let author: String
  let numComments: Int
  let createdUtc: Date
  let totalAwardsReceived: Int
  let url: String
  let allAwardings: [Award]
}

enum PostHint: String, Decodable {
  case image
  case link
  case unknown

  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let string = try container.decode(String.self)
    self = PostHint(rawValue: string) ?? .unknown
  }
}

struct Award: Codable {
  let resizedStaticIcons: [ResizedIcon]
  let count: Int
  let iconFormat: Format?
}

struct ResizedIcon: Codable {
  let url: String
}

enum Format: String, Codable {
  case apng = "APNG"
  case png = "PNG"
}
