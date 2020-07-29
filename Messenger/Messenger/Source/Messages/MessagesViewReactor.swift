//
//  MessagesViewReactor.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/19.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation

final class MessagesViewReactor: Reactor {
  
 typealias Action = NoAction
  
  struct State {
  }
  
  let initialState: State
  
  init() {
    self.initialState = State()
  }
}
