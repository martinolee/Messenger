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
    $0.tabBarItem.image = UIImage(systemName: "person")
    $0.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
  }
  
  let messagesViewController = NavigationController(TabBar.messages.viewController).then {
    $0.title = TabBar.messages.title.localized
    $0.tabBarItem.image = UIImage(systemName: "bubble.left")
    $0.tabBarItem.selectedImage = UIImage(systemName: "bubble.left.fill")
  }
  
  let settingsViewController = NavigationController(TabBar.settings.viewController).then {
    $0.title = TabBar.settings.title.localized
    $0.tabBarItem.image = UIImage(systemName: "gear")
    $0.tabBarItem.selectedImage = UIImage(systemName: "gear")
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
