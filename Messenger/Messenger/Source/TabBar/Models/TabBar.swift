//
//  TabBar.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/20.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

enum TabBar {
  case friends, messages, settings
}

extension TabBar {
  var viewController: UIViewController {
    switch self {
    case .friends:
      return FriendsViewController()
    case .messages:
      return MessagesViewController()
    case .settings:
      return SettingsViewController()
    }
  }
  
  var title: String {
    switch self {
    case .friends:
      return "Friends"
    case .messages:
      return "Messages"
    case .settings:
      return "Settings"
    }
  }
  
  var image: UIImage {
    switch self {
    case .friends:
      return UIImage(systemName: "person")!
    
    case .messages:
      return UIImage(systemName: "bubble.left")!
      
    case .settings:
      return UIImage(systemName: "gear")!
    }
  }
  
  var selectedImage: UIImage {
    switch self {
    case .friends:
      return UIImage(systemName: "person.fill")!
    
    case .messages:
      return UIImage(systemName: "bubble.left.fill")!
      
    case .settings:
      return UIImage(systemName: "gear")!
    }
  }
}
