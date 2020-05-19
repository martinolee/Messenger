//
//  LoginViewReactor.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/16.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation
import FirebaseAuth

final class LoginViewReactor: Reactor {
  enum Action {
    case updateEmail(String?)
    
    case updatePassword(String?)
    
    case logIn
  }
  
  enum Mutation {
    case setEmail(String)
    
    case setPassword(String)
    
    case setLoggingIn(Bool)
    
    case setLoggedin(Result<AuthDataResult, LoginError>)
  }
  
  struct State {
    var loginForm: LoginForm
    
    var isLoggingIn: Bool
    
    var loginResult: Result<AuthDataResult, LoginError>?
  }
  
  let initialState: State
  
  init() {
    self.initialState = State(loginForm: LoginForm(), isLoggingIn: false)
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .updateEmail(let email):
      guard let email = email else { return .empty() }
      
      return Observable.just(.setEmail(email))
      
    case .updatePassword(let password):
      guard let password = password else { return .empty() }
      
      return Observable.just(.setPassword(password))
      
    case .logIn:
      guard !currentState.isLoggingIn && currentState.loginForm.hasValidForm else { return .empty() }
      
      return Observable.concat([
        Observable.just(.setLoggingIn(true)),
        
        UserAccountManager.shared.logIn(currentState.loginForm)
          .map { Mutation.setLoggedin($0) },
        
        Observable.just(.setLoggingIn(false)),
      ])
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    
    switch mutation {
    case .setEmail(let email):
      state.loginForm.email = email
      
    case .setPassword(let password):
      state.loginForm.password = password
    
    case .setLoggingIn(let isLoggingIn):
      state.isLoggingIn = isLoggingIn
      
    case .setLoggedin(let result):
      state.loginResult = result
    }
    
    return state
  }
}
