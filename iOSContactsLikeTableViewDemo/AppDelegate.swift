//
//  AppDelegate.swift
//  iOSContactsLikeTableViewDemo
//
//  Created by Andrew Redko on 2/12/18.
//  Copyright © 2018 Andrii Redko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    
    let controller = EditTeamsViewController(nibName: "EditTeamsViewController", bundle: nil)
    let rootController = UINavigationController(rootViewController: controller)
    window!.rootViewController = rootController
    window!.makeKeyAndVisible()
    
    return true
  }
  
}
