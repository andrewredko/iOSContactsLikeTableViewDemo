//
//  EditPersonCell.swift
//  iOSContactsLikeTableViewDemo
//
//  Created by Andrew Redko on 2/12/18.
//  Copyright © 2018 Andrii Redko. All rights reserved.
//

import UIKit

protocol EditPersonCellDelegate : class {
  func selectPositionTapped(_ sender: EditPersonCell)
}

class EditPersonCell: UITableViewCell {
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var positionButton: UIButton!
  @IBOutlet weak var nameField: UITextField!
  
  // MARK: - IBActions
  @IBAction func positionButtonTapped() {
    delegate?.selectPositionTapped(self)
  }
  
  // MARK: - Public vars
  
  weak var delegate: EditPersonCellDelegate?
  
  private weak var _person: Person!
  var person: Person {
    get {
      return _person
    }
    set {
      _person = newValue
      nameField.text = newValue.name
      let positionString = newValue.position.rawValue
      positionButton.setTitle(positionString, for: .normal)
      nameField.placeholder = "Enter \(positionString.lowercased()) person"
    }
  }
  
  // MARK: - Setup
  override func awakeFromNib() {
    super.awakeFromNib()
    
    nameField.addTarget(self, action: #selector(handleEditingChanged(_:)),
                        for: .editingChanged)
    nameField.addTarget(self, action: #selector(handleEditingDidEnd),
                        for: .editingDidEndOnExit)
  }

  // MARK: - TextField handlers

  @objc private func handleEditingChanged(_ sender: UITextField) {
    _person.name = sender.text
  }
  
  @objc private func handleEditingDidEnd(_ sender: UITextField) {
    sender.resignFirstResponder()
  }
}
