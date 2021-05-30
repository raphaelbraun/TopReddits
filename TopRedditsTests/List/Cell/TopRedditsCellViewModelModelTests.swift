//
//  TopRedditsCellViewModelModelTests.swift
//  TopRedditsTests
//
//  Created by Raphael Braun on 30/05/21.
//

import XCTest
@testable import TopReddits

final class TopRedditsCellViewModelModelTests: XCTestCase {
  var sut = TopRedditsTableViewCell()
  var cellViewModel: TopRedditsCellViewModel!
  var service: TopRedditsWorkerProtocol!
  var topReddit: ChildData!
  var may29: Date!

  override func setUpWithError() throws {
    try super.setUpWithError()

    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd HH:mm"
    may29 = formatter.date(from: "2021/05/29 22:31")
    service = TopRedditsWorkerSuccessMock()
    service.fetchReddits(after: nil) { result in
      self.topReddit = try? result.get().data.children.first?.data
    }
    cellViewModel = TopRedditsCellViewModel(model: topReddit)
    cellViewModel.configure(cell: sut)
  }

  func testUsernameFormatting() {
    XCTAssertEqual(sut.authorLabel.text, "u/name_with_no_meaning")
  }

  func testUpsFormatting() {
    XCTAssertEqual(sut.postDataStackView.upsLabel.text, "129.5K")
  }

  func testNumCommentsFormatting() {
    XCTAssertEqual(sut.postDataStackView.numCommnetsLabel.text, "2.3K")
  }

  func testCreatedAtUtcFormatting() {
    let relativeDateFormatter = RelativeDateTimeFormatter()
    relativeDateFormatter.dateTimeStyle = .named
    let expectedDate = relativeDateFormatter.localizedString(for: topReddit.createdUtc, relativeTo: may29)
    sut.postDataStackView.createdAtLabel.text = expectedDate
    XCTAssertEqual(sut.postDataStackView.createdAtLabel.text, "12 hours ago")
  }
}
