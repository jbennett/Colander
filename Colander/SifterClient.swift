//
//  SifterClient.swift
//  Colander
//
//  Created by Jonathan Bennett on 2016-02-08.
//  Copyright © 2016 Jonathan Bennett. All rights reserved.
//

import Foundation
import BrightFutures

public class SifterClient {
  
  let networkClient: NetworkClient
  
  public init(configuration: SifterConfiguration) {
    self.networkClient = configuration.networkClient()
  }
  
  public func getProjects() -> Future<[Project], SifterError> {
    let promise = Promise<[Project], SifterError>()
    
    let projectsPromise = networkClient.getJSONResource("projects")
    projectsPromise.onSuccess {
      do {
        let projects = try $0.getArray("projects").map(Project.init)
        promise.success(projects)
      } catch {
        
      }
    }
    projectsPromise.onFailure { promise.failure(.Other($0)) }
    
    // TODO: implementation
    return promise.future
  }
  
  public func getIssuesForProject(project: Project) -> Future<[Issue], SifterError> {
    let promise = Promise<[Issue], SifterError>()
    // TODO: implementation
    return promise.future
  }
  
}

extension SifterClient { // callbacks
  
  public func getProjects(success: [Project] -> Void, failure: (SifterError -> Void)?) {
    let future = self.getProjects()
    
    future.onSuccess(callback: success)
    if let failure = failure {
      future.onFailure(callback: failure)
    }
  }
  
  public func getIssuesForProject(project: Project, success: [Issue] -> Void, failure: (SifterError -> Void)?) {
    let future = self.getIssuesForProject(project)
    
    future.onSuccess(callback: success)
    if let failure = failure {
      future.onFailure(callback: failure)
    }
  }
  
}