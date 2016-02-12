//
//  JSONError.swift
//  Colander
//
//  Created by Jonathan Bennett on 2016-02-09.
//  Copyright © 2016 Jonathan Bennett. All rights reserved.
//

import Foundation

enum JSONError: ErrorType {
  case InvalidData(NSData)
  case InvalidDataConversion(json: [String: AnyObject], key: String, value: Any, to: Any.Type)
}