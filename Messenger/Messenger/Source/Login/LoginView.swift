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
  
  let activityIndicatorView = UIActivityIndicatorView(style: .large)
  
  let dimView = UIView().then {
    $0.isHidden = true
    $0.backgroundColor = UIColor.black.withAlphaComponent(0.5)
  }
  
  let welcomeLabel = UILabel().then {
    $0.textAlignment = .center
    $0.text = "Welcome".localized
  }
  
  let idTextField = UITextField().then {
    $0.autocapitalizationType = .none
    $0.placeholder = "Email or phone number".localized
  }
  
  let pwTextField = UITextField().then {
    $0.isSecureTextEntry = true
    $0.placeholder = "Password".localized
  }
  
  let loginButton = UIButton(type: .system).then {
    $0.setTitle("Log In".localized, for: .normal)
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
      welcomeLabel,
      idTextField,
      pwTextField,
      loginButton,
      signupButton,
      findAccountOrPasswordButton,
      dimView,
    ])
    
    dimView.addSubview(activityIndicatorView)
  }
  
  func setUpLayout() {
    let safeArea = safeAreaLayoutGuide
    
    welcomeLabel.snp.makeConstraints {
      $0.top.equalTo(safeArea).inset(60)
      $0.leading.trailing.equalTo(safeArea).inset(8)
    }
    
    idTextField.snp.makeConstraints {
      $0.top.equalTo(welcomeLabel.snp.bottom).offset(60)
      $0.leading.trailing.equalTo(welcomeLabel)
    }
    
    pwTextField.snp.makeConstraints {
      $0.top.equalTo(idTextField.snp.bottom).offset(8)
      $0.leading.trailing.equalTo(welcomeLabel)
    }
    
    loginButton.snp.makeConstraints {
      $0.top.equalTo(pwTextField.snp.bottom).offset(16)
      $0.leading.trailing.equalTo(welcomeLabel)
    }
    
    signupButton.snp.makeConstraints {
      $0.top.equalTo(loginButton.snp.bottom).offset(8)
      $0.leading.trailing.equalTo(welcomeLabel)
    }
    
    dimView.snp.makeConstraints { $0.edges.equalToSuperview() }
    
    activityIndicatorView.snp.makeConstraints { $0.center.equalToSuperview() }
  }
}
