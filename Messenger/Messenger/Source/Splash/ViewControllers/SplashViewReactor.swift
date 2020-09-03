//
//  SplashViewReactor.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/09/03.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import ReactorKit


final class SplashViewReactor: Reactor {
  enum Action {
    case checkIfAuthenticated
  }
  
  enum Mutation {
    case setAuthenticated(Bool)
  }

  struct State {
    var isAuthenticated: Bool?
  }
  
  let initialState: State
  
  init() {
    self.initialState = State()
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .checkIfAuthenticated:
      return Observable.just(Mutation.setAuthenticated(false))
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    
    switch mutation {
    case .setAuthenticated(let isAuthenticated):
      newState.isAuthenticated = isAuthenticated
    }
    
    return newState
  }
}
