//
//  TopRedditsViewModelTests.swift
//  TopRedditsTests
//
//  Created by Raphael Braun on 30/05/21.
//

import XCTest
@testable import TopReddits

final class TopRedditsViewModelTests: XCTestCase {
  var sut: TopRedditsViewModelProtocol!
  var service: TopRedditsWorkerProtocol!

  override func setUpWithError() throws {
    try super.setUpWithError()

    service = TopRedditsWorkerSuccessMock()
    sut = TopRedditsViewModel(service: service)
  }

  override func tearDownWithError() throws {
    service = nil
    sut = nil

    super.tearDown()
  }

  func testNavigationTitle() {
    XCTAssertEqual(sut.navigationTitle, "Top")
  }

  func testLoadTop25RedditsWithViewModelInit() {
    XCTAssertEqual(sut.tableDataSource.models.count, 25)
  }

  func testLoadMoreReddits() {
    sut.loadMore()
    XCTAssertEqual(sut.tableDataSource.models.count, 50)
  }

  func testLoadFailure() {
    let failureMock = TopRedditsWorkerFailureMock()
    sut = TopRedditsViewModel(service: failureMock)
    XCTAssertEqual(sut.tableDataSource.models.count, 0)
  }
}
