//
//  JSON.swift
//  Colander
//
//  Created by Jonathan Bennett on 2016-02-09.
//  Copyright © 2016 Jonathan Bennett. All rights reserved.
//

import Foundation

struct JSON {
  
  let json: [String: AnyObject]
  
  init(json: [String: AnyObject]) {
    self.json = json
  }
  
  init(data: NSData) throws {
    guard let json = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String: AnyObject] else {
      throw JSONError.InvalidData(data)
    }
    
    self.json = json
  }

  func getString(key: String) throws -> String {
    guard let string = json[key] as? String else {
      throw JSONError.InvalidDataConversion(json: json, key: key, value: json[key], to: Swift.String)
    }
    
    return string
  }
  
  func getStringz(key: String) throws -> String? {
    guard json[key] != nil else {
      return .None
    }
    
    return json[key] as? String
  }
  
  func getInt(key: String) throws -> Int {
    guard let int = json[key] as? Int else {
      throw JSONError.InvalidDataConversion(json: json, key: key, value: json[key], to: Swift.Int)
    }
    
    return int
  }
  
  func getDouble(key: String) throws -> Double {
    guard let double = json[key] as? Double else {
      throw JSONError.InvalidDataConversion(json: json, key: key, value: json[key], to: Swift.Double)
    }
    
    return double
  }
  
  func getBool(key: String) throws -> Bool {
    guard let bool = json[key] as? Bool else {
      throw JSONError.InvalidDataConversion(json: json, key: key, value: json[key], to: Swift.Bool)
    }
    
    return bool
  }
  
  func getURL(key: String) throws -> NSURL {
    guard let url = try NSURL(string: getString(key)) else {
      throw JSONError.InvalidDataConversion(json: json, key: key, value: json[key], to: NSURL.self)
    }
    
    return url
  }
  
  func getArray(key: String) throws -> [JSON] {
    guard let array = json[key] as? [[String: AnyObject]] else {
      throw JSONError.InvalidDataConversion(json: json, key: key, value: json[key], to: Swift.Dictionary<String, AnyObject>)
    }
    
    return array.map(JSON.init)
  }
  
  func arrayOf<Decodable: JSONDecodable>(key: String) throws -> [Decodable] {
    return try getArray(key).map(Decodable.init)
  }
  
}

protocol JSONDecodable {
  init(json: JSON) throws
}