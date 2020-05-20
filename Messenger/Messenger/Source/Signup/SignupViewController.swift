//
//  SignupViewController.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/16.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

final class SignupViewController: UIViewController, View, ViewControllerSetup {
  // MARK: - Properties
  
  var disposeBag = DisposeBag()
  
  let signupView = SignupView()
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpRootView()
    setUpNavigation()
    self.hideKeyboardWhenTappedAround()
  }
  
  // MARK: - Setup
  
  func setUpRootView() {
    self.reactor = SignupViewReactor()
    
    view.addSubview(signupView)
    signupView.snp.makeConstraints { $0.edges.equalToSuperview() }
  }
  
  func setUpNavigation() {
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: signupView.cancelButton)
    navigationItem.title = "Sign Up".localized
  }
  
  func bind(reactor: SignupViewReactor) {
    // MARK: - Action
    
    signupView.cancelButton.rx.tap
      .subscribe(onNext: { [weak self] in
        guard let self = self else { return }
        
        self.dismiss(animated: true)
      })
      .disposed(by: disposeBag)
    
    signupView.nameTextField.rx.text.changed
      .distinctUntilChanged()
      .filterNil()
      .map { Reactor.Action.updateName($0) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    signupView.nameTextField.rx.controlEvent(.primaryActionTriggered)
    .subscribe(onNext: { [weak self] in
      guard let self = self else { return }
      
      self.signupView.emailTextField.becomeFirstResponder()
    })
    .disposed(by: disposeBag)
    
    signupView.emailTextField.rx.text.changed
      .distinctUntilChanged()
      .filterNil()
      .map { Reactor.Action.updateEmail($0) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    signupView.emailTextField.rx.controlEvent(.primaryActionTriggered)
      .subscribe(onNext: { [weak self] in
        guard let self = self else { return }
        
        self.signupView.passwordTextField.becomeFirstResponder()
      })
      .disposed(by: disposeBag)
    
    signupView.passwordTextField.rx.text.changed
      .distinctUntilChanged()
      .filterNil()
      .map { Reactor.Action.updatePassword($0) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    signupView.passwordTextField.rx.controlEvent(.primaryActionTriggered)
      .map { Reactor.Action.signUp }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    signupView.signupButton.rx.tap
      .map { Reactor.Action.signUp }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    // MARK: - State
    
    reactor.state.map { $0.signupForm.isFullyFormed }
      .distinctUntilChanged()
      .bind(to: signupView.signupButton.rx.isEnabled)
      .disposed(by: disposeBag)
    
    reactor.state.map { !$0.isCreatingUser }
      .distinctUntilChanged()
      .bind(to: signupView.dimView.rx.isHidden)
      .disposed(by: disposeBag)
    
    reactor.state.map { $0.isCreatingUser }
      .distinctUntilChanged()
      .bind(to: signupView.activityIndicatorView.rx.isAnimating)
      .disposed(by: disposeBag)
    
    reactor.state.map { $0.signupResult }
      .filterNil()
      .subscribe(onNext: { [weak self] result in
        guard let self = self else { return }
        
        switch result {
        case .success:
          self.dismiss(animated: true)
          
        case .failure(let error):
          let signupErrorAlert = UIAlertController(
            title: "Sign Up Error".localized,
            message: error.localizedDescription.localized,
            preferredStyle: .alert
          )
          signupErrorAlert.addAction(UIAlertAction(title: "Confirm".localized, style: .default))
          
          self.present(signupErrorAlert, animated: true)
        }
      })
      .disposed(by: disposeBag)
  }
}

