//
//  SyntaxTest.swift
//  Colander
//
//  Created by Jonathan Bennett on 2016-02-06.
//  Copyright © 2016 Jonathan Bennett. All rights reserved.
//

import Foundation

let configuration = SifterConfiguration(subdomain: "test", token: "abc123")
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

