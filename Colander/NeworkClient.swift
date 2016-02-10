//
//  NeworkClient.swift
//  Colander
//
//  Created by Jonathan Bennett on 2016-02-08.
//  Copyright © 2016 Jonathan Bennett. All rights reserved.
//

import Foundation
import BrightFutures
import Result

typealias xJSON = [String: AnyObject]

internal class NetworkClient {
  
  let session: NSURLSession
  let baseURL: NSURL
  
  init(session: NSURLSession, baseURL: NSURL) {
    self.session = session
    self.baseURL = baseURL
  }
  
  func getResource(resource: String) -> Future<NSData, NSError> {
    let promise = Promise<NSData, NSError>()
    let url = baseURL.URLByAppendingPathComponent(resource)
    
    let task = session.dataTaskWithURL(url) { data, response, error in
      if let error = error {
        promise.failure(error)
      } else {
        promise.success(data!)
      }
    }
    task.resume()
    
    return promise.future
  }
  
  func getJSONResource(resource: String) -> Future<JSON, NSError> {
    return getResource(resource).flatMap { data -> Result<JSON, NSError> in
      do {
        let json = try JSON(data: data)
        return .Success(json)
      } catch let error as NSError {
        return .Failure(error)
      }
    }
  }
  
}
