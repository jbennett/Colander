//
//  Project.swift
//  Colander
//
//  Created by Jonathan Bennett on 2016-02-07.
//  Copyright © 2016 Jonathan Bennett. All rights reserved.
//

import Foundation

public struct Project {
  
  let name: String
  let primaryCompanyName: String
  let archived: Bool
  
  let url: NSURL
  let issuesURL: NSURL
  let milestonesURL: NSURL
  let apiURL: NSURL
  let apiIssuesURL: NSURL
  let apiMilestonesURL: NSURL
  let apiCategoriesURL: NSURL
  let apiPeopleURL: NSURL
  
}

extension Project {
  
  init(json: JSON) throws {
    self.name = try json.getString("name")
    self.primaryCompanyName = try json.getString("primary_company_name")
    self.archived = try json.getBool("archived")
    
    self.url = try json.getURL("url")
    self.issuesURL = try json.getURL("issues_url")
    self.milestonesURL = try json.getURL("milestones_url")
    
    self.apiURL = try json.getURL("api_url")
    self.apiIssuesURL = try json.getURL("api_issues_url")
    self.apiMilestonesURL = try json.getURL("api_milestones_url")
    self.apiCategoriesURL = try json.getURL("api_categories_url")
    self.apiPeopleURL = try json.getURL("api_people_url")
  }
  
}
