//
//  ReadTeamsViewController.swift
//  iOSContactsLikeTableViewDemo
//
//  Created by Andrew Redko on 2/12/18.
//  Copyright © 2018 Andrii Redko. All rights reserved.
//

import UIKit

class ReadTeamsViewController: UIViewController {
  
  // MARK: - Private vars
  
  fileprivate let maximumPersons = Position.casesCount
  fileprivate let ReadTeamCellId = "ReadTeamCell"
  fileprivate let aRowHeight: CGFloat = 103
  
  fileprivate var teams: [Team]
 
  // MARK: - IBOutlets
  @IBOutlet fileprivate weak var tableView: UITableView!
  
  // MARK: - Initializers
  
  init(teams: [Team]) {
    self.teams = teams
    super.init(nibName: "ReadTeamsViewController", bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNavigationBar()
    setupTable()
  }
  
  private func setupNavigationBar() {
    self.title = "Teams"
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: "Edit",
      style: .plain,
      target: self,
      action: #selector(goToEditScreen))
  }
  
  @objc private func goToEditScreen() {
    self.dismiss(animated: true, completion: nil)
  }
  
  fileprivate func setupTable() {
    tableView.register(UINib(nibName: ReadTeamCellId, bundle: nil),
                  forCellReuseIdentifier: ReadTeamCellId)
    tableView.tableFooterView = UIView()
  }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension ReadTeamsViewController : UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return teams.count
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return getTeamCell(at: indexPath)
  }
  
  private func getTeamCell(at indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ReadTeamCellId,
                                        for: indexPath) as! ReadTeamCell
    cell.team = teams[indexPath.row]
    return cell
  }
}
