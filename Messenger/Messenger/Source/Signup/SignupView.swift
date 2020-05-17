//
//  SignUpView.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/16.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

class SignupView: UIView, ViewSetup {
  // MARK: - Properties
  
  let nameTextField = UITextField().then {
    $0.placeholder = "name".localized
  }
  
  let idTextField = UITextField().then {
    $0.placeholder = "email".localized
  }
  
  let pwTextField = UITextField().then {
    $0.isSecureTextEntry = true
    $0.placeholder = "password".localized
  }
  
  let confirmPWTextField = UITextField().then {
    $0.isSecureTextEntry = true
    $0.placeholder = "confirm".localized
  }
  
  // MARK: - Life Cycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setUpAttribute()
    addAllSubviews()
    setUpLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup UI
  
  func setUpAttribute() {
    self.backgroundColor = .systemBackground
  }
  
  func addAllSubviews() {
    self.addSubviews([
      nameTextField,
      idTextField,
      pwTextField,
      confirmPWTextField,
    ])
  }
  
  func setUpLayout() {
  }
}
