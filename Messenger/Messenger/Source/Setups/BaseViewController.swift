//
//  BaseViewController.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/28.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
  // MARK: - Properties
  
  var disposeBag = DisposeBag()
  
  
  // MARK: - Life Cycle
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required convenience init?(coder aDecoder: NSCoder) {
    self.init()
  }
  
  
  // MARK: Layout Constraints
  
  private(set) var didSetupConstraints = false

  override func viewDidLoad() {
    self.view.setNeedsUpdateConstraints()
  }

  override func updateViewConstraints() {
    if !self.didSetupConstraints {
      self.setupConstraints()
      self.didSetupConstraints = true
    }
    super.updateViewConstraints()
  }

  func setupConstraints() {
    // Override point
  }
}
