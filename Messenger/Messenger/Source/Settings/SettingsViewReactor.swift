//
//  SettingsViewReactor.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/19.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation

final class SettingsViewReactor: Reactor {
  typealias Action = NoAction
  
  typealias State = [Settings]
  
  let initialState: State
  
  init() {
    self.initialState = Settings.allCases.sorted(by: <)
  }
}
