//
//  BaseViewController.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/28.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, ViewControllerSetup {
  // MARK: - Properties
  
  var disposeBag = DisposeBag()
  
  
  // MARK: - Life Cycle
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }

  required convenience init?(coder aDecoder: NSCoder) {
    self.init()
  }
  
  
  // MARK: - Setup
  
  func setUpAttribute() {
  }
  
  func setUpRootView() {
  }
}
