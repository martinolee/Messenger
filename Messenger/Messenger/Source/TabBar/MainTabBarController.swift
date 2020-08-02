//
//  MainTabBarController.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/19.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

final class MainTabBarController: UITabBarController {
  // MARK: - Properties

  let friendsViewController = NavigationController(TabBar.friends.viewController).then {
    $0.title = TabBar.friends.title.localized
    $0.tabBarItem.image = TabBar.friends.image
    $0.tabBarItem.selectedImage = TabBar.friends.selectedImage
  }
  
  let messagesViewController = NavigationController(TabBar.messages.viewController).then {
    $0.title = TabBar.messages.title.localized
    $0.tabBarItem.image = TabBar.messages.image
    $0.tabBarItem.selectedImage = TabBar.messages.selectedImage
  }
  
  let settingsViewController = NavigationController(TabBar.settings.viewController).then {
    $0.title = TabBar.settings.title.localized
    $0.tabBarItem.image = TabBar.settings.image
    $0.tabBarItem.selectedImage = TabBar.settings.selectedImage
  }
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpAttribute()
    setUpViewControllers()
  }
  
  private func setUpAttribute() {
    tabBar.tintColor = .systemOrange
  }
  
  private func setUpViewControllers() {
    let viewControllers = [friendsViewController, messagesViewController, settingsViewController]
    
    self.viewControllers = viewControllers
  }
}
