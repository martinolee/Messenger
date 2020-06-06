//
//  AppDelegate.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/16.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

#if DEBUG
import Gedatsu;
#endif

import UIKit
import Firebase

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
    configureDebug()
    FirebaseApp.configure()
    setUpWindow()
    
    return true
  }
  
  private func setUpWindow() {
    window = UIWindow(frame: UIScreen.main.bounds)
    
    setUpRootViewControllerForUserLoginCondition()
    window?.makeKeyAndVisible()
  }
  
  func setUpRootViewControllerForUserLoginCondition() {
    rootViewController = AuthService.shared.isUserLoggedIn ? MainTabBarController() : LoginViewController()
  }
  
  private func configureDebug() {
    #if DEBUG
    Gedatsu.open()
    #endif
  }
}
