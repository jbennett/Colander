//
//  NeworkClient.swift
//  Colander
//
//  Created by Jonathan Bennett on 2016-02-08.
//  Copyright © 2016 Jonathan Bennett. All rights reserved.
//

import Foundation
import BrightFutures

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
  
  typealias JSON = [String: AnyObject]
  func getJSONResource(resource: String) -> Future<JSON, NSError> {
    return getResource(resource).flatMap { data -> Result<JSON, NSError> in
      do {
        let json = try NSJSONSerialization.JSONObjectWithData(data, options: [])
        return .Success(json)
      } catch error {
        return .Failure(error)
      }
    }
  }
  
}
