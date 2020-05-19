//
//  SignupViewReactor.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/16.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation
import FirebaseAuth

class SignupViewReactor: Reactor {
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
    
    case setSignupAvailable
    
    case setCreatingUser(Bool)
    
    case setUserCreationResult(Result<AuthDataResult,UserCreationError>)
  }
  
  struct State {
    var userCreationForm: UserCreationForm
    
    var isSignupAvailable: Bool
    
    var isCreatingUser: Bool
    
    var userCreationResult: Result<AuthDataResult,UserCreationError>?
  }
  
  let initialState: State
  
  init() {
    self.initialState = State(
      userCreationForm: UserCreationForm(),
      isSignupAvailable: false,
      isCreatingUser: false
    )
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .updateName(let name):
      let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
      
      return Observable.concat([
        Observable.just(.setName(trimmedName)),
        
        Observable.just(.setSignupAvailable),
      ])
      
    case .updateEmail(let email):
      let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
      
      return Observable.concat([
        Observable.just(.setEmail(trimmedEmail)),
        
        Observable.just(.setSignupAvailable),
      ])
      
    case .updatePassword(let password):
      return Observable.concat([
        Observable.just(.setPassword(password)),
        
        Observable.just(.setSignupAvailable),
      ])
      
    case .signUp:
      guard !currentState.isCreatingUser else { return .empty() }
      
      return Observable.concat([
        Observable.just(.setCreatingUser(true)),
        
        UserAccountManager.shared.creatUser(currentState.userCreationForm)
          .map { Mutation.setUserCreationResult($0) },
        
        Observable.just(.setCreatingUser(false)),
      ])
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    
    switch mutation {
    case .setName(let name):
      state.userCreationForm.name = name
      
    case .setEmail(let email):
      state.userCreationForm.email = email
      
    case .setPassword(let password):
      state.userCreationForm.password = password
      
    case .setSignupAvailable:
      state.isSignupAvailable = state.userCreationForm.isFullyFormed
      
    case .setCreatingUser(let isCreatingUser):
      state.isCreatingUser = isCreatingUser
      
    case .setUserCreationResult(let result):
      state.userCreationResult = result
    }
    
    return state
  }
}
