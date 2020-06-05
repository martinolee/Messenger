//
//  Settings.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/20.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation

enum Settings {
  case logOut
}

extension Settings {
  var title: String {
    switch self {
    case .logOut:
      return "Log Out"
    }
  }
  
  var id: Int {
    switch self {
    case .logOut:
      return 0
    }
  }
}

extension Settings: Comparable {
  static func < (lhs: Settings, rhs: Settings) -> Bool {
    return lhs.id < rhs.id
  }
}

extension Settings: CaseIterable {
}
