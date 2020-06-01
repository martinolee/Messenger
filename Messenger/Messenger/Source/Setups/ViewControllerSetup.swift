//
//  ViewControllerSetup.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/16.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit.UIViewController

protocol ViewControllerSetup where Self: UIViewController {
  func setUpAttribute()
  
  func setUpRootView()
}
