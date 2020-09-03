//
//  CompositionRoot.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/08/27.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

import Firebase
#if DEBUG
import Gedatsu
#endif


final class CompositionRoot {
  static func resolve(for windowScene: UIWindowScene) -> AppDependency {
    let window = UIWindow(windowScene: windowScene)
    window.makeKeyAndVisible()
    
    let presentLoginScreen: () -> Void = {
      let loginViewReactor = LoginViewReactor()
      let loginViewController = LoginViewController(
        reactor: loginViewReactor
      )
      
      window.rootViewController = loginViewController
    }
    let presentMainScreen: () -> Void = {
      let mainTabBarReactor = MainTabBarViewReactor()
      let mainTabBarController = MainTabBarController(
        reactor: mainTabBarReactor,
        friendsViewController: FriendsViewController(),
        messagesViewController: MessagesViewController(),
        settingsViewController: SettingsViewController()
      )
      
      window.rootViewController = mainTabBarController
    }
    
    let splashViewReactor = SplashViewReactor()
    let splashViewController = SplashViewController(
      reactor: splashViewReactor,
      presentLoginScreen: presentLoginScreen,
      presentMainScreen: presentMainScreen
    )
    window.rootViewController = splashViewController
    
    return AppDependency(
      window: window,
      configureSDKs: self.configureSDKs
    )
  }
  
  static func configureSDKs() {
    FirebaseApp.configure()
    #if DEBUG
    Gedatsu.open()
    #endif
  }
}
