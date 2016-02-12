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
      .onSuccess {
        if let first = $0.first {
          client.getIssuesForProject(first)
            .onSuccess {
              print($0)
              expectation.fulfill()
            }
            .onFailure { _ in
              XCTFail("Failed to get issues")
              expectation.fulfill()
            }
        }
      }
      .onFailure { _ in
        XCTFail("Failed to get content")
        expectation.fulfill()
      }
    
    self.waitForExpectationsWithTimeout(5, handler: nil)
  }
  
}
