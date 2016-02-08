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
  let categoryName: String
  let priority: String
  let subject: String
  let description: String
  let milestoneName: String
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