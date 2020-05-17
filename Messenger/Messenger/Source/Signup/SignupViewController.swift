//
//  SignupViewController.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/16.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController, View, ViewControllerSetup {
  // MARK: - Properties
  
  var disposeBag = DisposeBag()
  
  let signupView = SignupView()
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: - Setup
  
  func setUpRootView() {
    self.reactor = SignupViewReactor()
    
    view.addSubview(signupView)
    signupView.snp.makeConstraints { $0.edges.equalToSuperview() }
  }
  
  func bind(reactor: SignupViewReactor) {
    
  }
}

