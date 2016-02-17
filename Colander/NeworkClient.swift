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

internal enum NetworkError: ErrorType {
  case Authentication
  case Parse
  case Other(ErrorType)
}

internal class NetworkClient {
  
  let session: NSURLSession
  let baseURL: NSURL
  
  init(session: NSURLSession, baseURL: NSURL) {
    self.session = session
    self.baseURL = baseURL
  }
  
  func getContent(url: NSURL) -> Future<NSData, NetworkError> {
    let promise = Promise<NSData, NetworkError>()
    
    let task = session.dataTaskWithURL(url) { data, response, error in
      if let error = error {
        promise.failure(.Other(error))
        return
      }
      
      if let response = response as? NSHTTPURLResponse where response.statusCode != 200 {
        promise.failure(.Authentication)
        return
      }
      
      promise.success(data!)
    }
    task.resume()
    
    return promise.future
  }
  
  func getResource(resource: String) -> Future<NSData, NetworkError> {
    let url = URLForResource(resource)    
    return getContent(url)
  }
  
  func getJSONContent(url: NSURL) -> Future<JSON, NetworkError> {
    return getContent(url).flatMap { data -> Result<JSON, NetworkError> in
      do {
        let json = try JSON(data: data)
        return .Success(json)
      } catch {
        return .Failure(.Parse)
      }
    }
  }
  
  func getJSONResource(resource: String) -> Future<JSON, NetworkError> {
    let url = URLForResource(resource)
    return getJSONContent(url)
  }
  
  func URLForResource(resource: String) -> NSURL {
    return baseURL.URLByAppendingPathComponent(resource)
  }
  
}
