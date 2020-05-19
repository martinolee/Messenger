//
//  LoginViewController.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/16.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController, View, ViewControllerSetup {
  // MARK: - Properties
  
  var disposeBag = DisposeBag()
  
  let loginView = LoginView()
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpRootView()
    self.hideKeyboardWhenTappedAround()
  }
  
  // MARK: - Setup
  
  func setUpRootView() {
    self.reactor = LoginViewReactor()

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
        let signupViewController = UINavigationController(rootViewController: SignupViewController())
        
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
      .subscribe(onNext: { [weak self] result in
        guard self != nil else { return }
        
        switch result {
        case .success(let result):
          guard let window = (UIApplication.shared.delegate as? AppDelegate)?.window else { return }
          
          window.rootViewController = MainTabBarController()
          
        case .failure(let error):
          print(error.localizedDescription)
        }
      })
      .disposed(by: disposeBag)
  }
}
