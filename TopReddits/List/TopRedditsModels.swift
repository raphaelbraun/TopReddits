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
  let thumbnail: String
  let thumbnailHeight: Int?
  let subredditNamePrefixed: String
  let author: String
  let numComments: Int
  let createdUtc: Date
}
