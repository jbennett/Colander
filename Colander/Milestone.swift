//
//  Milestone.swift
//  Colander
//
//  Created by Jonathan Bennett on 2016-02-07.
//  Copyright © 2016 Jonathan Bennett. All rights reserved.
//

import Foundation

public struct Milestone {
  
  let name: String
  let dueDate: NSDate
  
  let issuesURL: NSURL
  let apiIssuesURL: NSURL
  
}

extension Milestone: JSONDecodable {
  
  init(json: JSON) throws {
    self.name = try json.getString("name")
    self.dueDate = NSDate() // TODO: add date parser
    
    self.issuesURL = try json.getURL("issues_url")
    self.apiIssuesURL = try json.getURL("api_issues_url")
  }
  
}