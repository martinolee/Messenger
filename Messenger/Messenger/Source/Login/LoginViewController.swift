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
  }
  
  // MARK: - Setup
  
  func setUpRootView() {
    self.reactor = LoginViewReactor()

    view.addSubview(loginView)
    loginView.snp.makeConstraints { $0.edges.equalToSuperview() }
  }
  
  func bind(reactor: LoginViewReactor) {
    // MARK: - Action
    
    loginView.idTextField.rx.text.changed
      .map { Reactor.Action.updateUsername($0) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    loginView.pwTextField.rx.text.changed
      .map { Reactor.Action.updatePassword($0) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    loginView.loginButton.rx.tap
      .map { Reactor.Action.logIn }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    loginView.signupButton.rx.tap
      .subscribe(onNext: { [weak self] in
        guard let self = self else { return }
        let signupViewController = SignupViewController()
        
        self.present(signupViewController, animated: true)
      })
      .disposed(by: disposeBag)
    
    // MARK: - State
    
    reactor.state.map { $0.isLoginAvailable }
      .subscribe(onNext: { [weak self] isLoginAvailable in
        guard let self = self else { return }
        
        isLoginAvailable
          ? (self.loginView.loginButton.isEnabled = true)
          : (self.loginView.loginButton.isEnabled = false)
      })
      .disposed(by: disposeBag)
    
    reactor.state.map { $0.isLoggedin }
      .subscribe(onNext: { [weak self] isLoggedin in
        guard let self = self else { return }
        
        if isLoggedin {
          print(self)
        }
      })
      .disposed(by: disposeBag)
  }
}
