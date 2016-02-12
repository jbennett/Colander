//
//  Email.swift
//  Colander
//
//  Created by Jonathan Bennett on 2016-02-08.
//  Copyright © 2016 Jonathan Bennett. All rights reserved.
//

import Foundation

public struct EmailAddress {
  
  let value: String
  
}

extension JSON {
  func getEmailAddress(key: String) throws -> EmailAddress {
    let emailString = try getString(key)
    return EmailAddress(value: emailString)
  }
}