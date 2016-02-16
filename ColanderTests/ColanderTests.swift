//
//  ColanderTests.swift
//  ColanderTests
//
//  Created by Jonathan Bennett on 2016-02-06.
//  Copyright © 2016 Jonathan Bennett. All rights reserved.
//

import XCTest
import Colander

class ColanderTests: XCTestCase {
    
  
  func testExample() {
    let expectation = self.expectationWithDescription("networking")
    let config = try! SifterConfiguration(subdomain: TestKeys.domain, token: TestKeys.token)
    let client = SifterClient(configuration: config)
    
    client.getProjects()
      .map { $0.first! }
      .flatMap { client.getIssuesForProject($0) }
      .onSuccess { _ in
        expectation.fulfill()
      }
      .onFailure {
        XCTFail("Failed to get issues: \($0)")
        expectation.fulfill()
      }
    
    self.waitForExpectationsWithTimeout(5, handler: nil)
  }
  
  func testCanGetMilestones() {
    let expectation = self.expectationWithDescription("retrieving milestones")
    let config = try! SifterConfiguration(subdomain: TestKeys.domain, token: TestKeys.token)
    let client = SifterClient(configuration: config)
    
    client.getProjects()
      .map { $0.first! }
      .flatMap { client.getMilestonesForProject($0) }
      .onSuccess { _ in
        expectation.fulfill()
      }
      .onFailure {
        XCTFail("Failed to get milestones: \($0)")
        expectation.fulfill()
    }

    self.waitForExpectationsWithTimeout(5, handler: nil)
  }
  
  func testCanGetCategories() {
    let expectation = self.expectationWithDescription("retrieving categories")
    let config = try! SifterConfiguration(subdomain: TestKeys.domain, token: TestKeys.token)
    let client = SifterClient(configuration: config)
    
    client.getProjects()
      .map { $0.first! }
      .flatMap { client.getCategoriesForProject($0) }
      .onSuccess {
        print($0)
        expectation.fulfill()
      }
      .onFailure {
        XCTFail("Failed to get milestones: \($0)")
        expectation.fulfill()
    }
    
    self.waitForExpectationsWithTimeout(5, handler: nil)
  }
  
}
