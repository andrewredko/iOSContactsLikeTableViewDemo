//
//  ReadTeamCell.swift
//  iOSContactsLikeTableViewDemo
//
//  Created by Andrew Redko on 2/12/18.
//  Copyright © 2018 Andrii Redko. All rights reserved.
//

import UIKit

class ReadTeamCell: UITableViewCell {
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var managerLabel: UILabel!
  @IBOutlet weak var iosLabel: UILabel!
  @IBOutlet weak var androidLabel: UILabel!
  @IBOutlet weak var xamarinLabel: UILabel!
  
  // MARK: - Public vars
  var team: Team! {
    didSet {
      let dict = buildLabelsDict(from: team)
      managerLabel.text = dict[.manager]
      iosLabel.text     = dict[.ios]
      androidLabel.text = dict[.android]
      xamarinLabel.text = dict[.xamarin]
    }
  }
  
  // MARK: - Private methods
  
  
  private func buildLabelsDict(from team: Team) -> [Position: String] {
    var dict = [Position: String]()
    for p in team.persons {
      if let labelText = buildLabelText(from: p) {
        dict[p.position] = labelText
      }
    }
    return dict
  }
  
  private func buildLabelText(from person: Person) -> String? {
    switch person.position {
    case .manager:
      return person.name
    case .ios, .android, .xamarin:
      if let safeName = person.name {
        return "\(person.position.rawValue): \(safeName)"
      } else {
        return nil
      }
    }
  }
}
