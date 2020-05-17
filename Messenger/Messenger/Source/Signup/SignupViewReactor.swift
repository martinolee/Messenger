//
//  SignupViewReactor.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/16.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation

class SignupViewReactor: Reactor {
  enum Action {
    
  }
  
  enum Mutation {
    
  }
  
  struct State {
    
  }
  
  let initialState: State
  
  init() {
    self.initialState = State()
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    .empty()
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    .init()
  }
}
