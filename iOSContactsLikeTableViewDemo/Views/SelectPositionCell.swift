//
//  SelectPositionCell.swift
//  iOSContactsLikeTableViewDemo
//
//  Created by Andrew Redko on 2/12/18.
//  Copyright © 2018 Andrii Redko. All rights reserved.
//

import UIKit

class SelectPositionCell: UITableViewCell {
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var checkmarkImage: UIImageView!
  
  // MARK: - Public vars
  
  var title: String? = nil {
    didSet {
      titleLabel.text = title
    }
  }
  
  var checkmarkIsHidden: Bool = true {
    didSet {
      checkmarkImage.isHidden = checkmarkIsHidden
    }
  }
  
  var enabled: Bool = true {
    didSet {
      if enabled {
        titleLabel.alpha = 1.0
        self.isUserInteractionEnabled = true
      } else {
        titleLabel.alpha = 0.439216
        self.isUserInteractionEnabled = false
      }
    }
  }
  
}
