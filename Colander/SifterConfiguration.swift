//
//  SifterConfiguration.swift
//  Colander
//
//  Created by Jonathan Bennett on 2016-02-08.
//  Copyright © 2016 Jonathan Bennett. All rights reserved.
//

import Foundation

public struct SifterConfiguration {
  
  let subdomain: String
  let baseURL: NSURL
  let token: String
  let sessionClass: NSURLSession.Type
  
  public init(subdomain: String, token: String, sessionClass: NSURLSession.Type = NSURLSession.self) throws {
    self.subdomain = subdomain
    self.token = token
    self.sessionClass = sessionClass
    
    let baseURLString = "https://\(subdomain).sifterapp.com/api/"
    if let baseURL = NSURL(string: baseURLString) {
      self.baseURL = baseURL
    } else {
      throw SifterError.InvalidDomain("https://\(subdomain).sifterapp.com/api/")
    }
  }
  
  func networkClient() -> NetworkClient {
    let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
    configuration.HTTPAdditionalHeaders = sessionHeaders()
    let session = sessionClass.init(configuration: configuration)
    
    return NetworkClient(session: session, baseURL: baseURL)
  }
  
  private func sessionHeaders() -> [NSObject: AnyObject] {
    return [
      "X-Sifter-Token": token,
      "Accept": "application/json",
    ]
  }
  
}