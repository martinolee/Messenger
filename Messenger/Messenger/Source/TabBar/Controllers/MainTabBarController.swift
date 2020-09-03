//
//  MainTabBarController.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/19.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

import ReactorKit
import RxSwift
import RxCocoa


final class MainTabBarController: UITabBarController, View {
  
  // MARK: - Properties
  
  var disposeBag = DisposeBag()
  
  
  // MARK: - Initialization
  
  init(
    reactor: MainTabBarViewReactor,
    friendsViewController: FriendsViewController,
    messagesViewController: MessagesViewController,
    settingsViewController: SettingsViewController
  ) {
    defer { self.reactor = reactor }
    super.init(nibName: nil, bundle: nil)
    self.viewControllers = [friendsViewController, messagesViewController, settingsViewController]
      .map({ viewControlller -> NavigationController in
        return NavigationController(viewControlller)
      })
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: - Bind
  
  func bind(reactor: MainTabBarViewReactor) {
  }
}
