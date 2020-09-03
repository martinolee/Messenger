//
//  SplashViewController.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/09/03.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

import ReactorKit
import RxSwift
import RxCocoa
import RxViewController


final class SplashViewController: BaseViewController, View {
  
  // MARK: - Properties
  
  private let presentLoginScreen: () -> Void
  private let presentMainScreen: () -> Void
  
  
  // MARK: - Initialization
  
  init(
    reactor: SplashViewReactor,
    presentLoginScreen: @escaping () -> Void,
    presentMainScreen: @escaping () -> Void
  ) {
    defer { self.reactor = reactor }
    self.presentLoginScreen = presentLoginScreen
    self.presentMainScreen = presentMainScreen
    super.init()
  }
  
  
  // MARK: - Bind
  
  func bind(reactor: SplashViewReactor) {
    
    // Action
    
    self.rx.viewDidAppear
      .map { _ in Reactor.Action.checkIfAuthenticated }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    
    // State
    
    self.reactor?.state.map { $0.isAuthenticated }
      .filterNil()
      .distinctUntilChanged()
      .subscribe(onNext: { [weak self] isAuthenticated in
        isAuthenticated
          ? self?.presentMainScreen()
          : self?.presentLoginScreen()
      })
      .disposed(by: disposeBag)
  }
}
