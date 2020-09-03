//
//  SplashViewReactor.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/09/03.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import ReactorKit


final class SplashViewReactor: Reactor {
  typealias Action = NoAction
  
  struct State {
  }
  
  let initialState: State
  
  init() {
    self.initialState = State()
  }
}
