//
//  CarListTests.swift
//  CarListTests
//
//  Created by siwook on 2017. 10. 23..
//  Copyright © 2017년 siwook. All rights reserved.
//

import XCTest
@testable import CarList

// MARK: - CarListTests: XCTestCase
class CarListTests: XCTestCase {

  // MARK: - Property List
  var sessionUnderTest: URLSession!
  var restClient: RestClient!
  var carInfoList: [CarInfo]!

  // MARK: - Set up
  override func setUp() {
    super.setUp()
    sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
    restClient = RestClient()
  }

  // MARK: - Tear Down
  override func tearDown() {
    super.tearDown()
    sessionUnderTest = nil
    restClient = nil
    carInfoList = nil
  }

  // MARK: - Test Car List Fetching
  func testValidCallToCarListGetHTTPStatusCode200() {

    let promise = expectation(description: "Receive car list json")
    guard let url = URL(string: Constants.API.BaseURL) else { return }
    restClient.taskForResource(with: url) { (carInfoList, error) in
      if let error = error {
        XCTFail("\(error.localizedDescription)")
      } else {
        guard let carInfoList = carInfoList else { return }
        self.carInfoList = carInfoList
        promise.fulfill()
      }
    }
    waitForExpectations(timeout: 5, handler: nil)
  }

  // MARK: - Test the number of Car List
  func testFetchedCarInfoList() {
    testValidCallToCarListGetHTTPStatusCode200()
    XCTAssertEqual(carInfoList.count, 28, "couldn't fetch 26 items")
  }
  // MARK: - Test the value of the Car List array 
  func testFirstFetchedCarHasExpectedValues() {
    testValidCallToCarListGetHTTPStatusCode200()
    verifyFetchedCarListHasExpectedValues(index:0)
  }
  func verifyFetchedCarListHasExpectedValues(index: Int) {
    let car = carInfoList[index]
    XCTAssertEqual(car.modelIdentifier, "mini")
    XCTAssertEqual(car.modelName, "MINI")
    XCTAssertEqual(car.name, "Vanessa")
  }
}
