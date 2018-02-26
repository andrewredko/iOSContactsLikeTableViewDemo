//
//  SelectPositionViewController.swift
//  iOSContactsLikeTableViewDemo
//
//  Created by Andrew Redko on 2/12/18.
//  Copyright © 2018 Andrii Redko. All rights reserved.
//

import UIKit

protocol SelectPositionViewControllerDelegate : class {
  func handlePositionSelected(_ position: Position)
}

class SelectPositionViewController: UIViewController {
  
  // MARK: - Private vars
  
  fileprivate let cellId = "SelectPositionCell"
  fileprivate let cellHeight: CGFloat = 44
  
  fileprivate let positions = Position.valuesSorted
  fileprivate let takenPositions: [Position]
  fileprivate var selectedPosition: Position
  
  // MARK: - Public vars
  weak var delegate: SelectPositionViewControllerDelegate?
  
  // MARK: - IBOutlets
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: - Initializers
  
  init(current: Position, takenPositions: [Position]) {
    selectedPosition = current
    self.takenPositions = takenPositions.filter { $0 != current }
    
    super.init(nibName: "SelectPositionViewController", bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "Select Position"
    setupNavigationBar()
    setupTableView()
  }

  private func setupNavigationBar() {
    self.navigationItem.rightBarButtonItem = createNavBarDoneButton()
    self.navigationItem.leftBarButtonItem = createNavBarCancelButton()
  }
  
  private func createNavBarDoneButton() -> UIBarButtonItem {
    return UIBarButtonItem(title: "Done", style: .done, target: self,
                                 action: #selector(doneButtonTapped))
  }
  
  @objc private func doneButtonTapped() {
    delegate?.handlePositionSelected(selectedPosition)
    dismissSelf()
  }
  
  private func createNavBarCancelButton() -> UIBarButtonItem {
    return UIBarButtonItem(title: "Cancel", style: .plain, target: self,
                           action: #selector(cancelButtonTapped))
  }
  
  @objc private func cancelButtonTapped() {
    dismissSelf()
  }
  
  private func dismissSelf() {
    self.navigationController?.dismiss(animated: true, completion: nil)
  }

  private func setupTableView() {
    tableView.register(UINib(nibName: cellId, bundle: nil),
                       forCellReuseIdentifier: cellId)
    tableView.backgroundColor = UIColor(fromRGB: 0xF7F7F7)
    let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 999, height: 28))
    headerView.backgroundColor = UIColor.clear
    tableView.tableHeaderView = headerView
    tableView.tableFooterView = UIView()
  }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension SelectPositionViewController: UITableViewDataSource, UITableViewDelegate {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return positions.count
  }
  
  func tableView(_ tableView: UITableView,
                 heightForRowAt indexPath: IndexPath) -> CGFloat {
    return cellHeight
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return UIScreen.pixelSize
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return UIScreen.pixelSize
  }

  func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    let aView = view as! UITableViewHeaderFooterView
    aView.contentView.backgroundColor = UIColor(fromRGB: 0xC8C7CC)
  }

  func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
    let aView = view as! UITableViewHeaderFooterView
    aView.contentView.backgroundColor = UIColor(fromRGB: 0xC8C7CC)
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId,
                                             for: indexPath) as! SelectPositionCell
    let position = positions[indexPath.row]
    cell.title = position.rawValue
    cell.checkmarkIsHidden = position != selectedPosition
    cell.enabled = !takenPositions.contains(position)
    return cell
  }
  
  func tableView(_ tableView: UITableView,
                 didSelectRowAt indexPath: IndexPath) {
    let position = positions[indexPath.row]
    if position != selectedPosition {
      switchSelectedPosition(from: selectedPosition, to: position)
    }
    tableView.deselectRow(at: indexPath, animated: false)
  }
  
  private func switchSelectedPosition(from fromPosition: Position, to toPosition: Position) {
    selectedPosition = toPosition
    getCell(of: fromPosition).checkmarkIsHidden = true
    getCell(of: toPosition).checkmarkIsHidden = false
  }
  
  private func getCell(of position: Position) -> SelectPositionCell {
    let indexPath = IndexPath(row: positions.index(of: position)!, section: 0)
    return tableView.cellForRow(at: indexPath) as! SelectPositionCell
  }
}
