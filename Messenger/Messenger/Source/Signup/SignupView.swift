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
  
  let dimView = UIView().then {
    $0.isHidden = true
    $0.backgroundColor = .black
    $0.alpha = 0.5
  }
  
  let activityIndicatorView = UIActivityIndicatorView().then {
    $0.hidesWhenStopped = true
    $0.style = .large
  }
  
  let cancelButton = UIButton(type: .system).then {
    $0.setImage(UIImage(systemName: "xmark"), for: .normal)
  }
  
  let nameTextField = UITextField().then {
    $0.autocorrectionType = .no
    $0.autocapitalizationType = .words
    $0.placeholder = "Name".localized
  }
  
  let usernameTextField = UITextField().then {
    $0.autocorrectionType = .no
    $0.autocapitalizationType = .none
    $0.placeholder = "Email".localized
  }
  
  let passwordTextField = UITextField().then {
    $0.isSecureTextEntry = true
    $0.placeholder = "Password".localized
  }
  
  let signupButton = UIButton(type: .system).then {
    $0.setTitle("Sign Up".localized, for: .normal)
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
      usernameTextField,
      passwordTextField,
      signupButton,
      dimView,
    ])
    
    dimView.addSubview(activityIndicatorView)
  }
  
  func setUpLayout() {
    let safeArea = safeAreaLayoutGuide
    
    dimView.snp.makeConstraints { $0.edges.equalToSuperview() }
    
    activityIndicatorView.snp.makeConstraints { $0.center.equalToSuperview() }
    
    nameTextField.snp.makeConstraints {
      $0.top.equalTo(safeArea).inset(60)
      $0.leading.trailing.equalToSuperview().inset(16)
    }
    
    usernameTextField.snp.makeConstraints {
      $0.top.equalTo(nameTextField.snp.bottom).offset(8)
      $0.leading.trailing.equalTo(nameTextField)
    }
    
    passwordTextField.snp.makeConstraints {
      $0.top.equalTo(usernameTextField.snp.bottom).offset(8)
      $0.leading.trailing.equalTo(nameTextField)
    }
    
    signupButton.snp.makeConstraints {
      $0.top.equalTo(passwordTextField).offset(18)
      $0.leading.trailing.equalTo(nameTextField)
    }
  }
}
