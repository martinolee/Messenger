//
//  NavigationController.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/06/01.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit.UINavigationController

class NavigationController: UINavigationController {
  // MARK: - Life Cycle
  
  init(_ rootViewController: UIViewController) {
    super.init(nibName: nil, bundle: nil)
    pushViewController(rootViewController, animated: false)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
