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
  let token: String
  let sessionClass: NSURLSession.Type
  
  public init(subdomain: String, token: String, sessionClass: NSURLSession.Type = NSURLSession.self) {
    self.subdomain = subdomain
    self.token = token
    self.sessionClass = sessionClass
  }
  
  
}