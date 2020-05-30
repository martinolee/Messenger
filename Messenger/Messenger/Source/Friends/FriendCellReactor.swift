//
//  FriendCellReactor.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/27.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation

class FriendCellReactor: Reactor {
  typealias Action = NoAction
  
  struct State {
    var friend: User
  }
  
  let initialState: State
  
  init(friend: User) {
    self.initialState = State(friend: friend)
  }
}
