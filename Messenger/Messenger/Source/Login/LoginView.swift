//
//  LoginView.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/16.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

final class LoginView: BaseView, ViewSetup {
  
  // MARK: - Constants
  
  private enum Metric {
    static let padding = 16
    
    static let height = 50
  }
  
  private enum Font {
    static let loginButtonFont = UIFont.systemFont(ofSize: 24, weight: .bold)
  }
  
  private enum Color {
    static let dimViewBackground = UIColor.black.withAlphaComponent(0.5)
    
    static let activityIndicatorView = UIColor.systemOrange
    
    static let loginButtonNormalTitle = UIColor.white
    
    static let loginButtonDisabledTitle = UIColor.white.withAlphaComponent(0.5)
    
    static let loginButtonNormalBackground = UIColor.systemOrange
    
    static let loginButtonDisabledBackground = UIColor.lightGray
    
    static let signupButtonTitle = UIColor.systemOrange
  }
  
  
  // MARK: - Properties
  
  let dimView = UIView().then {
    $0.isHidden = true
    $0.backgroundColor = Color.dimViewBackground
  }
  
  let activityIndicatorView = UIActivityIndicatorView().then {
    $0.hidesWhenStopped = true
    $0.style = .large
    $0.color = Color.activityIndicatorView
  }
  
  let emailTextField = UITextField().then {
    $0.textContentType = .emailAddress
    $0.autocorrectionType = .no
    $0.autocapitalizationType = .none
    $0.keyboardType = .emailAddress
    $0.returnKeyType = .next
    $0.placeholder = "Email".localized
  }
  
  let passwordTextField = UITextField().then {
    $0.textContentType = .password
    $0.isSecureTextEntry = true
    $0.placeholder = "Password".localized
  }
  
  let loginButton = UIButton(type: .system).then {
    $0.clipsToBounds = true
    $0.layer.cornerRadius = 6
    
    $0.titleLabel?.font = Font.loginButtonFont
    
    $0.setTitle("Log In".localized, for: .normal)
    
    $0.setTitleColor(Color.loginButtonNormalTitle, for: .normal)
    $0.setTitleColor(Color.loginButtonDisabledTitle, for: .disabled)
    
    $0.setBackgroundColor(Color.loginButtonNormalBackground, for: .normal)
    $0.setBackgroundColor(Color.loginButtonDisabledBackground, for: .disabled)
  }
  
  let signupButton = UIButton(type: .system).then {
    $0.setTitle("Sign Up".localized, for: .normal)
    $0.setTitleColor(Color.signupButtonTitle, for: .normal)
  }
  
  let findAccountOrPasswordButton = UIButton(type: .system).then {
    $0.setTitle("Find Account or Password".localized, for: .normal)
  }
  
  
  // MARK: - Life Cycle
  
  override init() {
    super.init()
    
    setUpAttribute()
    addAllSubviews()
    setUpLayout()
  }
  
  
  // MARK: - Setup UI
  
  func setUpAttribute() {
    self.backgroundColor = .systemBackground
    self.hideKeyboardWhenTappedAround()
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
    
    dimView.addSubviews([
      activityIndicatorView,
    ])
  }
  
  func setUpLayout() {
    let safeArea = safeAreaLayoutGuide
    
    dimView.snp.makeConstraints { $0.edges.equalToSuperview() }
    
    activityIndicatorView.snp.makeConstraints { $0.center.equalToSuperview() }
    
    emailTextField.snp.makeConstraints {
      $0.top.equalTo(safeArea).offset(Metric.padding)
      $0.leading.trailing.equalTo(safeArea).inset(Metric.padding)
      $0.height.equalTo(Metric.height)
    }
    
    passwordTextField.snp.makeConstraints {
      $0.top.equalTo(emailTextField.snp.bottom).offset(Metric.padding)
      $0.leading.trailing.equalTo(emailTextField)
      $0.height.equalTo(Metric.height)
    }
    
    loginButton.snp.makeConstraints {
      $0.top.equalTo(passwordTextField.snp.bottom).offset(Metric.padding)
      $0.leading.trailing.equalTo(emailTextField)
      $0.height.equalTo(Metric.height)
    }
    
    signupButton.snp.makeConstraints {
      $0.top.equalTo(loginButton.snp.bottom).offset(Metric.padding)
      $0.leading.trailing.equalTo(emailTextField)
    }
  }
}
