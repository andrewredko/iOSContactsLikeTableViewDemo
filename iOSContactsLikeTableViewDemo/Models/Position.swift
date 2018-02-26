//
//  Position.swift
//  iOSContactsLikeTableViewDemo
//
//  Created by Andrew Redko on 2/12/18.
//  Copyright © 2018 Andrii Redko. All rights reserved.
//

import Foundation

enum Position: String {
  case manager = "Manager"
  case ios     = "iOS"
  case android = "Android"
  case xamarin = "Xamarin"
  
  
  static let casesCount = 4
  
  static let valuesSorted: [Position] = [.manager,
                                         .ios,
                                         .android,
                                         .xamarin]
  
  static func getNext(for positions: [Position]) -> Position? {
    guard positions.count > 0 else {
      return valuesSorted.first
    }
    let diff = valuesSorted.filter { !positions.contains($0) }
    return diff.first
  }
}
