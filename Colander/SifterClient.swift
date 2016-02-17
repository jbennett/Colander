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
    let url = networkClient.URLForResource("projects")
    return getResource(url, resourceName: "projects")
  }
  
  public func getIssuesForProject(project: Project) -> Future<[Issue], SifterError> {
    let url = project.apiIssuesURL
    return getResource(url, resourceName: "issues")
  }
  
  public func getMilestonesForProject(project: Project) -> Future<[Milestone], SifterError> {
    let url = project.apiMilestonesURL
    return getResource(url, resourceName: "milestones")
  }
  
  public func getCategoriesForProject(project: Project) -> Future<[Category], SifterError> {
    let url = project.apiCategoriesURL
    return getResource(url, resourceName: "categories")
  }
  
  
  public func getPeopleForProject(project: Project) -> Future<[Person], SifterError> {
    let url = project.apiPeopleURL
    return getResource(url, resourceName: "people")
  }
  
  public func getStatuses() -> Future<[Status], SifterError> {
    let promise = Promise<[Status], SifterError>()
    
    networkClient.getJSONResource("statuses")
      .onSuccess {
        do {
          let rawStatuses = try $0.getJSON("statuses")
          let statuses = try rawStatuses.keys.map {
            return try Status(name: $0, number: rawStatuses.getInt($0))
          }
          
          promise.success(statuses)
        } catch let error {
          // todo: handle it
          promise.failure(SifterError.Other(error))
        }
      }
      .onFailure { promise.failure(SifterError.Other($0)) }
    
    return promise.future
  }
  
  public func getPriorities() -> Future<[Priority], SifterError> {
    let promise = Promise<[Priority], SifterError>()
    
    networkClient.getJSONResource("priorities")
      .onSuccess {
        do {
          let rawPriorities = try $0.getJSON("priorities")
          let priorities = try rawPriorities.keys.map {
            return try Priority(name: $0, number: rawPriorities.getInt($0))
          }
          
          promise.success(priorities)
        } catch let error {
          // todo: handle it
          promise.failure(SifterError.Other(error))
        }
      }
      .onFailure { promise.failure(SifterError.Other($0)) }
    
    return promise.future
  }
  
  
  private func getResource<T:JSONDecodable>(url: NSURL, resourceName: String) -> Future<[T], SifterError> {
    let promise = Promise<[T], SifterError>()
    
    networkClient.getJSONContent(url)
      .onSuccess { json in
        do {
          let resource: [T] = try json.arrayOf(resourceName)
          promise.success(resource)
        } catch {
          // TODO: Handle it
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