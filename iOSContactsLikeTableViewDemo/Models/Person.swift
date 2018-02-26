//
//  Person.swift
//  iOSContactsLikeTableViewDemo
//
//  Created by Andrew Redko on 2/12/18.
//  Copyright © 2018 Andrii Redko. All rights reserved.
//

import Foundation

class Person {
  var position: Position
  var name: String?
  
  init(position: Position, name: String?) {
    self.position = position
    self.name = name
  }
  
  convenience init(position: Position) {
    self.init(position: position, name: nil)
  }
}
