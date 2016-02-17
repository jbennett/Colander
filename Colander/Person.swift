//
//  Person.swift
//  Colander
//
//  Created by Jonathan Bennett on 2016-02-07.
//  Copyright © 2016 Jonathan Bennett. All rights reserved.
//

import Foundation

public struct Person {
  
  let username: String
  let firstName: String
  let lastName: String
  let email: EmailAddress
  
  let issuesURL: NSURL
  let apiIssuesURL: NSURL
  
}

extension Person: JSONDecodable {
  
  init(json: JSON) throws {
    self.username = try json.getString("username")
    self.firstName = try json.getString("first_name")
    self.lastName = try json.getString("last_name")
    self.email = try json.getEmailAddress("email")
    
    self.issuesURL = try json.getURL("issues_url")
    self.apiIssuesURL = try json.getURL("api_issues_url")
  }
  
}