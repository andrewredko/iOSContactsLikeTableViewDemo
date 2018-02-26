//
//  UIColor+Ex.swift
//  iOSContactsLikeTableViewDemo
//
//  Created by Andrew Redko on 2/12/18.
//  Copyright © 2018 Andrii Redko. All rights reserved.
//

import UIKit

extension UIColor {
  
  convenience init(fromRGB rgbValue: UInt, alpha: Double) {
    self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
              green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
              blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
              alpha: CGFloat(alpha)
    )
  }

  convenience init(fromRGB rgbValue: UInt) {
    self.init(fromRGB: rgbValue, alpha: 1.0)
  }
}
