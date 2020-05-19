//
//  LoginView.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/16.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

final class LoginView: UIView, ViewSetup {
  // MARK: - Properties
  
  let dimView = UIView().then {
    $0.isHidden = true
    $0.backgroundColor = UIColor.black.withAlphaComponent(0.5)
  }
  
  let activityIndicatorView = UIActivityIndicatorView().then {
    $0.hidesWhenStopped = true
    $0.style = .large
    $0.color = .white
  }
  
  let emailTextField = UITextField().then {
    $0.autocorrectionType = .no
    $0.autocapitalizationType = .none
    $0.keyboardType = .emailAddress
    $0.placeholder = "Email".localized
  }
  
  let passwordTextField = UITextField().then {
    $0.isSecureTextEntry = true
    $0.placeholder = "Password".localized
  }
  
  let loginButton = UIButton(type: .system).then {
    $0.clipsToBounds = true
    $0.layer.cornerRadius = 6
    
    $0.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
    
    $0.setTitle("Log In".localized, for: .normal)
    
    $0.setTitleColor(.white, for: .normal)
    $0.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .disabled)
    
    $0.setBackgroundColor(.systemOrange, for: .normal)
    $0.setBackgroundColor(.lightGray, for: .disabled)
  }
  
  let signupButton = UIButton(type: .system).then {
    $0.setTitle("Sign Up".localized, for: .normal)
  }
  
  let findAccountOrPasswordButton = UIButton(type: .system).then {
    $0.setTitle("Find Account or Password".localized, for: .normal)
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
      emailTextField,
      passwordTextField,
      loginButton,
      signupButton,
      findAccountOrPasswordButton,
      dimView,
    ])
    
    dimView.addSubview(activityIndicatorView)
  }
  
  func setUpLayout() {
    let safeArea = safeAreaLayoutGuide
    
    dimView.snp.makeConstraints { $0.edges.equalToSuperview() }
    
    activityIndicatorView.snp.makeConstraints { $0.center.equalToSuperview() }
    
    emailTextField.snp.makeConstraints {
      $0.top.equalTo(safeArea).offset(16)
      $0.leading.trailing.equalTo(safeArea).inset(16)
      $0.height.equalTo(50)
    }
    
    passwordTextField.snp.makeConstraints {
      $0.top.equalTo(emailTextField.snp.bottom).offset(8)
      $0.leading.trailing.equalTo(emailTextField)
      $0.height.equalTo(50)
    }
    
    loginButton.snp.makeConstraints {
      $0.top.equalTo(passwordTextField.snp.bottom).offset(16)
      $0.leading.trailing.equalTo(emailTextField)
      $0.height.equalTo(50)
    }
    
    signupButton.snp.makeConstraints {
      $0.top.equalTo(loginButton.snp.bottom).offset(8)
      $0.leading.trailing.equalTo(emailTextField)
    }
    
    dimView.snp.makeConstraints { $0.edges.equalToSuperview() }
    
    activityIndicatorView.snp.makeConstraints { $0.center.equalToSuperview() }
  }
}
