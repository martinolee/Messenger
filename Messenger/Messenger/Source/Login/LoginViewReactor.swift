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
    case updateUsername(String?)
    
    case updatePassword(String?)
    
    case logIn
  }
  
  enum Mutation {
    case setUsername(String)
    
    case setPassword(String)
    
    case setLoginState
  }
  
  struct State {
    var username: String?
    
    var password: String?
    
    var isLoggedin: Bool {
      didSet {
        print("didSet", isLoggedin)
      }
    }
    
    var isLoginAvailable: Bool
    
    var isLoading: Bool
  }
  
  let initialState: State
  
  init() {
    self.initialState = State(isLoggedin: false, isLoginAvailable: false, isLoading: false)
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .updateUsername(let username):
      guard let username = username else { return .empty() }
      
      return Observable.just(.setUsername(username))
      
    case .updatePassword(let password):
      guard let password = password else { return .empty() }
      
      return Observable.just(.setPassword(password))
      
    case .logIn:
      return Observable.just(.setLoginState)
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    
    switch mutation {
    case .setUsername(let username):
      state.username = username
      
    case .setPassword(let password):
      state.password = password
      
    case .setLoginState:
      guard let username = state.username, let password = state.password else { return state }
      
      Auth.auth().signIn(withEmail: username, password: password) { result, error in
        guard error == nil else { return print(error!.localizedDescription) }
        guard let result = result else { return }
        
        state.isLoggedin = true
      }
    }
    
    !(state.username?.isEmpty ?? true) && state.password?.count ?? 0 >= 4
      ? (state.isLoginAvailable = true)
      : (state.isLoginAvailable = false)
    
    return state
  }
}
