//
//  Issue.swift
//  Colander
//
//  Created by Jonathan Bennett on 2016-02-07.
//  Copyright © 2016 Jonathan Bennett. All rights reserved.
//

import Foundation

public struct Issue {
  
  let number: Int
  let categoryName: String?
  let priority: String
  let subject: String
  let description: String
  let milestoneName: String?
  let openerName: String
  let openerEmail: EmailAddress
  let assigneeName: String
  let assigneeEmail: EmailAddress
  let status: String
  let commentCount: Int
  let attachmentCount: Int
  let createdAt: NSDate
  let updatedAt: NSDate
  let url: NSURL
  let apiURL: NSURL
  
}

extension Issue: JSONDecodable {
  
  init(json: JSON) throws {
    self.number = try json.getInt("number")
    self.categoryName = try? json.getString("category_name")
    self.priority = try json.getString("priority")
    self.subject = try json.getString("subject")
    self.description = try json.getString("description")
    self.milestoneName = try? json.getString("milestone_name")
    self.openerName = try json.getString("opener_name")
    self.openerEmail = EmailAddress() // TODO:
    self.assigneeName = try json.getString("assignee_name")
    self.assigneeEmail = EmailAddress() // TODO:
    self.status = try json.getString("status")
    self.commentCount = try json.getInt("comment_count")
    self.attachmentCount = try json.getInt("attachment_count")
    self.createdAt = NSDate()
    self.updatedAt = NSDate()
    self.url = try json.getURL("url")
    self.apiURL = try json.getURL("api_url")
  }
}