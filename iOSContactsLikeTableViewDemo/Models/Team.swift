//
//  Team.swift
//  iOSContactsLikeTableViewDemo
//
//  Created by Andrew Redko on 2/12/18.
//  Copyright © 2018 Andrii Redko. All rights reserved.
//

import Foundation

class Team {
  
  let maximumPersons = Position.casesCount
  
  private (set) var persons: [Person]
  
  init(persons: [Person]) {
    self.persons = persons
  }
  
  private func addPersonIfNotEmpty(_ name: String?, position: Position) {
    if let name = name, !name.isEmpty {
      persons.append(Person(position: position, name: name))
    }
  }
  
  var rowsCount: Int {
    get {
      let personsCount = persons.count
      return personsCount < maximumPersons ? personsCount + 1 : personsCount
    }
  }
  
  var hasAllPersons: Bool {
    return persons.count >= maximumPersons
  }
  
  var hasOnePerson: Bool {
    return persons.count == 1
  }
  
  func addNextPerson() {
    guard !hasAllPersons else {
      return
    }
    persons.append(Person(position: getNextPosition()!))
  }
  
  func getPerson(at index: Int) -> Person {
    return persons[index]
  }
  
  func deletePerson(at index: Int) {
    persons.remove(at: index)
  }
  
  func getNextPosition() -> Position? {
    return Position.getNext(for: getTakenPositions())
  }
  
  func getTakenPositions() -> [Position] {
    return persons.map { $0.position }
  }
  
  var isEmpty: Bool {
    for person in persons {
      if let name = person.name, !name.isEmpty {
        return false
      }
    }
    return true
  }
  
}
