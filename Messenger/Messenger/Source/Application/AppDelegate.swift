//
//  AppDelegate.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/16.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    setUpRootViewController()
    FirebaseApp.configure()
    
    return true
  }
  
  private func setUpRootViewController() {
    window = UIWindow(frame: UIScreen.main.bounds)
    
    window?.rootViewController = LoginViewController()
    window?.makeKeyAndVisible()
  }
}

