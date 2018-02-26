//
//  AddItemCell.swift
//  iOSContactsLikeTableViewDemo
//
//  Created by Andrew Redko on 2/12/18.
//  Copyright © 2018 Andrii Redko. All rights reserved.
//

import UIKit

protocol AddItemCellDelegate {
  func addItemTapped(sender: UITableViewCell)
}

class AddItemCell: UITableViewCell {

  enum ImageType {
    case blue
    case green
  }
  
  // MARK: - IBOutlets
  
  @IBOutlet fileprivate weak var addButton: UIButton!
  @IBOutlet fileprivate weak var separatorView: UIView!
  
  // MARK: - Public vars
  
  var delegate: AddItemCellDelegate?
  
  var name: String? {
    get { return addButton.title(for: .normal) }
    set { addButton.setTitle(newValue, for: .normal) }
  }

  var imageType: ImageType = .blue {
    didSet {
      switch imageType {
      case .blue:
        addButton.setImage(#imageLiteral(resourceName: "AddCell_Blue"), for: .normal)
      case .green:
        addButton.setImage(#imageLiteral(resourceName: "AddCell_Green"), for: .normal)
      }
    }
  }
  
  var showSeparator: Bool = false {
    didSet {
      separatorView.isHidden = !showSeparator
    }
  }
  
  // MARK: - IBActions
  @IBAction func addButtonTapped(_ sender: Any) {
    delegate?.addItemTapped(sender: self)
  }
}
