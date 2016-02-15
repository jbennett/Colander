//
//  SifterClient.swift
//  Colander
//
//  Created by Jonathan Bennett on 2016-02-08.
//  Copyright © 2016 Jonathan Bennett. All rights reserved.
//

import Foundation
import BrightFutures
import Result

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
        let projects: [Project] = try $0.arrayOf("projects")
        promise.success(projects)
      } catch {
        // todo: handle it
      }
    }
    projectsPromise.onFailure { promise.failure(SifterError.Other($0)) }

    return promise.future
  }
  
  public func getIssuesForProject(project: Project) -> Future<[Issue], SifterError> {
    let promise = Promise<[Issue], SifterError>()
    
    let issuesPromise = networkClient.getJSONContent(project.apiIssuesURL)
    issuesPromise.onSuccess {
      do {
        let issues: [Issue] = try $0.arrayOf("issues")
        promise.success(issues)
      } catch let error {
        // todo: handle it
        print(error)
      }
    }
    issuesPromise.onFailure { promise.failure(SifterError.Other($0)) }
    
    return promise.future
  }
  
  public func getMilestonesForProject(project: Project) -> Future<[Milestone], SifterError> {
    let promise = Promise<[Milestone], SifterError>()
    
    networkClient.getJSONContent(project.apiMilestonesURL)
      .onSuccess {
        do {
          let milestones: [Milestone] = try $0.arrayOf("milestones")
          promise.success(milestones)
        } catch let error {
          // todo: handle it
          promise.failure(SifterError.Other(error))
        }
      }
      .onFailure { promise.failure(SifterError.Other($0)) }
    
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