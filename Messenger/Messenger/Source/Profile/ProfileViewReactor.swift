//
//  ProfileViewReactor.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/23.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation

final class ProfileViewReactor: Reactor {
  enum Action {
    case startMessaging
  }
  
  typealias State = User
  
  var initialState: State
  
  init(user: User) {
    self.initialState = user
  }
}
