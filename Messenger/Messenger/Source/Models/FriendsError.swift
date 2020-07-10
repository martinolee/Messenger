//
//  FriendsError.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/22.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation

enum FriendsError: Error {
  case firebaseError(Error)
  
  case userNotFound
}

extension FriendsError {
  var localizedDescription: String {
    switch self {
    case .firebaseError(let error):
      return error.localizedDescription
    case .userNotFound:
      return "User not found".localized
    }
  }
}
