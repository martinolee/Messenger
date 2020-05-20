//
//  AppDelegate.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/16.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  var rootViewController: UIViewController? {
    get {
      window?.rootViewController
    }
    
    set {
      window?.rootViewController = newValue
    }
  }
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()
    try? Auth.auth().signOut()
    setUpWindow()
    
    return true
  }
  
  private func setUpWindow() {
    window = UIWindow(frame: UIScreen.main.bounds)
    
    setUpRootViewControllerForUserLoginCondition()
    window?.makeKeyAndVisible()
  }
  
  func setUpRootViewControllerForUserLoginCondition() {
    rootViewController = UserAccountManager.shared.isUserLoggedIn ? MainTabBarController() : LoginViewController()
  }
}

