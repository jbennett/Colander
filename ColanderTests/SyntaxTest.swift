//
//  SyntaxTest.swift
//  Colander
//
//  Created by Jonathan Bennett on 2016-02-06.
//  Copyright © 2016 Jonathan Bennett. All rights reserved.
//

import Foundation
import Colander

let configuration = try! SifterConfiguration(subdomain: "test", token: "abc123")
let client = SifterClient(configuration)

client
  .getProjects()
  .flatMap { $0.first }
  .flatMap { client.getIssuesForProject($0) }
  .flatMap { $0.first }
  .flatMap { issue in
    print(issue)
    let comment = Comment(/* */)
    client.saveComment(comment, forIssue: issue)
  }
  .onSuccess({ print("saved successfully") })
  .onFailure({ print("failed to do stuff: \($0)") })

client.getProjects(
  success: {
    guard let project = projects.first else { return }
    self?.client.getIssuesForProject(project,
      success: { issues in
        guard let issue = issues.first else { return }
        print(issue)
        let comment = Comment(/* */)
        client.saveComment(comment, forIssue: issue,
          success: {
            print("saved successfully")
          }, failure: {
            print("failed to do stuff: \($0)")
          }
        )
      }, failure: {
        
      }
    )
  }, failure: {
    
  }
)