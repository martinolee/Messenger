//
//  SignupViewReactor.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/16.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation
import FirebaseAuth

final class SignupViewReactor: Reactor {
  enum Action {
    case updateName(String)
    
    case updateEmail(String)
    
    case updatePassword(String)
    
    case signUp
  }
  
  enum Mutation {
    case setName(String)
    
    case setEmail(String)
    
    case setPassword(String)
    
    case setCreatingUser(Bool)
    
    case setSignupResult(AuthDataResult)
    
    case setSignupError(Error)
  }
  
  struct State {
    var signupForm: SignupForm
    
    var isCreatingUser: Bool
    
    var signupResult: AuthDataResult?
    
    var signupError: RevisionedError?
  }
  
  let initialState: State
  
  init() {
    self.initialState = State(
      signupForm: SignupForm(),
      isCreatingUser: false
    )
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .updateName(let name):
      let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
      
      return Observable.just(.setName(trimmedName))
      
    case .updateEmail(let email):
      let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
      
      return Observable.just(.setEmail(trimmedEmail))
      
    case .updatePassword(let password):
      return Observable.just(.setPassword(password))
      
    case .signUp:
      guard
        !currentState.isCreatingUser &&
          currentState.signupForm.isFullyFormed
      else { return .empty() }
      guard
        let name = currentState.signupForm.name,
        let email = currentState.signupForm.email,
        let password = currentState.signupForm.password
      else { return .empty() }
      
      return Observable.concat([
        Observable.just(.setCreatingUser(true)),
        
        AuthService.shared.signUp(name: name, email: email, password: password)
          .map { .setSignupResult($0) }
          .catchError { .just(.setSignupError($0)) },
        
        Observable.just(.setCreatingUser(false)),
      ])
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    
    switch mutation {
    case .setName(let name):
      state.signupForm.name = name
      
    case .setEmail(let email):
      state.signupForm.email = email
      
    case .setPassword(let password):
      state.signupForm.password = password
      
    case .setCreatingUser(let isCreatingUser):
      state.isCreatingUser = isCreatingUser
      
    case .setSignupResult(let result):
      state.signupResult = result
      
    case .setSignupError(let error):
      state.signupError = RevisionedError(
        revision: (state.signupError?.revision ?? 0) + 1,
        error: error
      )
    }
    
    return state
  }
}
