//
//  SignUpView.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/16.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

final class SignupView: UIView, ViewSetup {
  
  // MARK: - Constants
  
  private enum Metric {
    static let padding = 16
    
    static let height = 50
  }
  
  private enum Font {
    static let signupButton = UIFont.systemFont(ofSize: 24, weight: .bold)
  }
  
  private enum Color {
    static let dimView = UIColor.black.withAlphaComponent(0.5)
    
    static let activityIndicatorView = UIColor.systemOrange
    
    static let cancelButton = UIColor.systemOrange
    
    static let signupButtonNormalTitle = UIColor.white
    
    static let signupButtonDisabledTitle = UIColor.white.withAlphaComponent(0.5)
    
    static let signupButtonNormalBackground = UIColor.systemOrange
    
    static let signupButtonDisabledBackground = UIColor.lightGray
  }
  
  
  // MARK: - Properties
  
  let dimView = UIView().then {
    $0.isHidden = true
    $0.backgroundColor = Color.dimView
  }
  
  let activityIndicatorView = UIActivityIndicatorView().then {
    $0.hidesWhenStopped = true
    $0.style = .large
    $0.color = Color.activityIndicatorView
  }
  
  let cancelButton = UIButton(type: .system).then {
    $0.setImage(UIImage(systemName: "xmark"), for: .normal)
    $0.tintColor = Color.cancelButton
  }
  
  let nameTextField = UITextField().then {
    $0.textContentType = .name
    $0.autocorrectionType = .no
    $0.autocapitalizationType = .words
    $0.returnKeyType = .next
    $0.placeholder = "Name".localized
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
  
  let signupButton = UIButton(type: .system).then {
    $0.clipsToBounds = true
    $0.layer.cornerRadius = 6
    
    $0.titleLabel?.font = Font.signupButton
    
    $0.setTitle("Sign Up".localized, for: .normal)
    
    $0.setTitleColor(Color.signupButtonNormalTitle, for: .normal)
    $0.setTitleColor(Color.signupButtonDisabledTitle, for: .disabled)
    
    $0.setBackgroundColor(Color.signupButtonNormalBackground, for: .normal)
    $0.setBackgroundColor(Color.signupButtonDisabledBackground, for: .disabled)
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
    self.hideKeyboardWhenTappedAround()
  }
  
  func addAllSubviews() {
    self.addSubviews([
      nameTextField,
      emailTextField,
      passwordTextField,
      signupButton,
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
    
    nameTextField.snp.makeConstraints {
      $0.top.equalTo(safeArea).inset(Metric.padding)
      $0.leading.trailing.equalToSuperview().inset(Metric.padding)
      $0.height.equalTo(Metric.height)
    }
    
    emailTextField.snp.makeConstraints {
      $0.top.equalTo(nameTextField.snp.bottom).offset(Metric.padding)
      $0.leading.trailing.equalTo(nameTextField)
      $0.height.equalTo(Metric.height)
    }
    
    passwordTextField.snp.makeConstraints {
      $0.top.equalTo(emailTextField.snp.bottom).offset(Metric.padding)
      $0.leading.trailing.equalTo(nameTextField)
      $0.height.equalTo(Metric.height)
    }
    
    signupButton.snp.makeConstraints {
      $0.top.equalTo(passwordTextField.snp.bottom).offset(Metric.padding)
      $0.leading.trailing.equalTo(nameTextField)
      $0.height.equalTo(Metric.height)
    }
  }
}
