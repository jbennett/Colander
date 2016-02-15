//
//  Category.swift
//  Colander
//
//  Created by Jonathan Bennett on 2016-02-07.
//  Copyright © 2016 Jonathan Bennett. All rights reserved.
//

import Foundation

public struct Category {
  let name: String
  
  let issuesURL: NSURL
  let apiIssuesURL: NSURL
}

extension Category: JSONDecodable {
  
  init(json: JSON) throws {
    self.name = try json.getString("name")
    self.issuesURL = try json.getURL("issues_url")
    self.apiIssuesURL = try json.getURL("api_issues_url")
  }
  
}