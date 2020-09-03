//
//  LoginViewController.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/16.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

final class LoginViewController: BaseViewController, View {
  
  // MARK: - Properties
  
  let loginView = LoginView()
  
  
  // MARK: - Initialization
  
  init(
    reactor: LoginViewReactor
  ) {
    defer { self.reactor = reactor }
    super.init()
  }
  
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpAttribute()
    setUpRootView()
  }
  
  // MARK: - Setup
  
  func setUpAttribute() {
  }
  
  func setUpRootView() {
    view.addSubview(loginView)
    loginView.snp.makeConstraints { $0.edges.equalToSuperview() }
  }
  
  func bind(reactor: LoginViewReactor) {
    // MARK: - Action
    
    loginView.emailTextField.rx.text.changed
      .distinctUntilChanged()
      .map { Reactor.Action.updateEmail($0) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    loginView.emailTextField.rx.controlEvent(.primaryActionTriggered)
      .subscribe(onNext: { [weak self] in
        guard let self = self else { return }
        
        self.loginView.passwordTextField.becomeFirstResponder()
      })
      .disposed(by: disposeBag)
    
    loginView.passwordTextField.rx.text.changed
      .distinctUntilChanged()
      .map { Reactor.Action.updatePassword($0) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    loginView.passwordTextField.rx.controlEvent(.primaryActionTriggered)
      .map { Reactor.Action.logIn }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    loginView.loginButton.rx.tap
      .map { Reactor.Action.logIn }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    loginView.signupButton.rx.tap
      .subscribe(onNext: { [weak self] in
        guard let self = self else { return }
        let signupViewController = NavigationController(SignupViewController())
        
        self.present(signupViewController, animated: true)
      })
      .disposed(by: disposeBag)
    
    // MARK: - State
    
    reactor.state.map { !$0.isLoggingIn }
      .distinctUntilChanged()
      .bind(to: loginView.dimView.rx.isHidden)
      .disposed(by: disposeBag)
    
    reactor.state.map { $0.isLoggingIn }
      .distinctUntilChanged()
      .bind(to: loginView.activityIndicatorView.rx.isAnimating)
      .disposed(by: disposeBag)
    
    reactor.state.map { $0.loginForm.hasValidForm }
      .distinctUntilChanged()
      .bind(to: loginView.loginButton.rx.isEnabled)
      .disposed(by: disposeBag)
    
    reactor.state.map { $0.loginResult }
      .filterNil()
      .distinctUntilChanged()
      .subscribe(onNext: { [weak self] _ in
        guard self != nil else { return }
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
//        appDelegate.setUpRootViewControllerForUserLoginCondition()
        })
      .disposed(by: disposeBag)
    
    reactor.state.map { $0.loginError }
      .filterNil()
      .distinctUntilChanged()
      .subscribe(onNext: { [weak self] error in
        guard let self = self else { return }
        let error = error.error
        
        let signupErrorAlert = UIAlertController(
          title: "Log In Error".localized,
          message: error.localizedDescription.localized,
          preferredStyle: .alert
        )
        signupErrorAlert.addAction(UIAlertAction(title: "Confirm".localized, style: .default))
        
        self.present(signupErrorAlert, animated: true)
      })
      .disposed(by: disposeBag)
  }
}
