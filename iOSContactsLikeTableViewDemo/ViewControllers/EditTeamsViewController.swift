//
//  EditTeamsViewController.swift
//  iOSContactsLikeTableViewDemo
//
//  Created by Andrew Redko on 2/12/18.
//  Copyright © 2018 Andrii Redko. All rights reserved.
//

import UIKit

class EditTeamsViewController: UIViewController {
  
  // MARK: - Private vars
  
  fileprivate let maximumPersons = Position.casesCount
  fileprivate let personCellId = "EditPersonCell"
  fileprivate let addItemCellId = "AddItemCell"
  fileprivate let aSectionHeaderHeight: CGFloat = 0
  fileprivate let aSectionFooterHeight: CGFloat = 20
  fileprivate let aRowHeight: CGFloat = 44

  fileprivate var teams = [Team]()
  fileprivate var indexPathOfPositionSelecting: IndexPath!
  
  fileprivate var originalInsets: UIEdgeInsets!
  

  // MARK: - IBOutlets
  @IBOutlet fileprivate weak var tableView: UITableView!
  
  // MARK: - Setup
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNavigationBar()
    setupTable()
    setupKeyboardAdjustments()
  }
  
  private func setupNavigationBar() {
    self.title = "Edit Teams"
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: "Save",
      style: .done,
      target: self,
      action: #selector(goToReadScreen))
  }
  
  fileprivate func setupTable() {
    tableView.register(UINib(nibName: personCellId, bundle: nil),
                  forCellReuseIdentifier: personCellId)
    tableView.register(UINib(nibName: addItemCellId, bundle: nil),
                  forCellReuseIdentifier: addItemCellId)
    tableView.allowsSelection = false
    tableView.tableFooterView = UIView()
    tableView.sectionHeaderHeight = aSectionHeaderHeight
    tableView.sectionFooterHeight = aSectionFooterHeight
    tableView.dataSource = self
    tableView.delegate = self
  }
  
  // MARK: - Save
  @objc private func goToReadScreen() {
    let nonEmptyTeams = teams.filter { !$0.isEmpty  }
    let readController = ReadTeamsViewController(teams: nonEmptyTeams )
    let nc = UINavigationController(rootViewController: readController)
    nc.modalPresentationStyle = .custom
    nc.modalTransitionStyle = .crossDissolve
    self.present(nc, animated: true, completion: nil)
  }
  
  // MARK: - Adjust content per keyboard
  
  private func setupKeyboardAdjustments() {
    originalInsets = tableView.contentInset
    NotificationCenter.default.addObserver(
      self, selector: #selector(keyboardDidShow(notification:)),
      name: NSNotification.Name.UIKeyboardDidShow, object: nil)
    NotificationCenter.default.addObserver(
      self, selector: #selector(keyboardDidHide(notification:)),
      name: NSNotification.Name.UIKeyboardDidHide, object: nil)
  }
  
  @objc private func keyboardDidShow(notification : Notification) {
    guard let keyboardSize = notification.userInfo?[UIKeyboardFrameEndUserInfoKey]
      as? CGRect else {
        return
    }
    
    let insets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
    tableView.contentInset = insets
    tableView.scrollIndicatorInsets = insets
  }
  
  @objc private func keyboardDidHide(notification : Notification) {
    tableView.contentInset = originalInsets
    tableView.scrollIndicatorInsets = originalInsets
  }
  
  // MARK: - DataSource helpers
  
  fileprivate func isLastSection(_ section: Int) -> Bool {
    return section >= teams.count
  }
  
  fileprivate func isPersonCell(at indexPath: IndexPath) -> Bool {
    let team = teams[indexPath.section]
    return indexPath.row < team.persons.count
  }
  
  fileprivate func getPerson(at indexPath: IndexPath) -> Person {
    return teams[indexPath.section].getPerson(at: indexPath.row)
  }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension EditTeamsViewController : UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return teams.count + 1
  }
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    if isLastSection(section) {
      return 1
    } else {
      return teams[section].rowsCount
    }
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: aSectionFooterHeight))
    view.backgroundColor = .clear
    return view
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return aSectionFooterHeight
  }
  
  func tableView(_ tableView: UITableView,
                 heightForRowAt indexPath: IndexPath) -> CGFloat {
    return aRowHeight
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard !isLastSection(indexPath.section) else {
      return getAddTeamCell(at: indexPath)
    }
    if isPersonCell(at: indexPath) {
      return getPersonCell(at: indexPath)
    } else {
      return getAddPersonCell(at: indexPath)
    }
  }
  
  private func getPersonCell(at indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: personCellId,
                                        for: indexPath) as! EditPersonCell
    cell.person = teams[indexPath.section].persons[indexPath.row]
    cell.delegate = self
    return cell
  }
  
  private func getAddPersonCell(at indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: addItemCellId,
                                        for: indexPath) as! AddItemCell
    cell.name = "Add Person"
    cell.imageType = .blue
    cell.showSeparator = true
    cell.delegate = self
    return cell
  }
  
  fileprivate func getAddTeamCell(at indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: addItemCellId,
                                        for: indexPath) as! AddItemCell
    cell.name = "Add Team"
    cell.imageType = .green
    cell.showSeparator = false
    cell.delegate = self
    return cell
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    guard !isLastSection(indexPath.section) else {
      return false
    }
    return isPersonCell(at: indexPath)
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let team = teams[indexPath.section]
      if team.hasAllPersons {
        team.deletePerson(at: indexPath.row)
        let addItemIndexPath = IndexPath(row: team.rowsCount-1,
                                         section: indexPath.section)
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.insertRows(at: [addItemIndexPath], with: .automatic)
        tableView.endUpdates()
      } else if team.hasOnePerson {
        teams.remove(at: indexPath.section)
        tableView.deleteSections([indexPath.section], with: .top)
      } else {
        team.deletePerson(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
      }
    }
  }
}

// MARK: - AddItemCellDelegate
extension EditTeamsViewController: AddItemCellDelegate {
  
  func addItemTapped(sender: UITableViewCell) {
    if let indexPath = tableView.indexPath(for: sender) {
      if isLastSection(indexPath.section) {
        addTeamTapped()
      } else {
        addPersonTapped(in: indexPath.section)
      }
    }
  }
  
  private func addPersonTapped(in section: Int) {
    let team = teams[section]
    team.addNextPerson()
    if team.hasAllPersons {
      let indexPath = IndexPath(row: team.rowsCount-1, section: section)
      tableView.beginUpdates()
      tableView.deleteRows(at: [indexPath], with: .automatic)
      tableView.insertRows(at: [indexPath], with: .automatic)
      tableView.endUpdates()
    } else {
      let indexPath = IndexPath(row: team.rowsCount-2, section: section)
      tableView.insertRows(at: [indexPath], with: .automatic)
    }
  }
  
  private func addTeamTapped() {
    let persons = [Person(position: .manager)]
    teams.append(Team(persons: persons))
    tableView.insertSections([teams.count-1], with: .top)
  }
}

// MARK: - EditPersonCellDelegate
extension EditTeamsViewController : EditPersonCellDelegate {
  func selectPositionTapped(_ sender: EditPersonCell) {
    if let indexPath = tableView.indexPath(for: sender) {
      indexPathOfPositionSelecting = indexPath
      let controller = SelectPositionViewController(
        current: sender.person.position,
        takenPositions: teams[indexPath.section].getTakenPositions())
      controller.delegate = self
      let navController = UINavigationController(rootViewController: controller)
      self.present(navController, animated: true, completion: nil)
    }
  }
}

// MARK: - SelectPositionViewControllerDelegate
extension EditTeamsViewController : SelectPositionViewControllerDelegate {
  func handlePositionSelected(_ position: Position) {
    let person = getPerson(at: indexPathOfPositionSelecting)
    person.position = position
    tableView.reloadRows(at: [indexPathOfPositionSelecting], with: .automatic)
  }
}
