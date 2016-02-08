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