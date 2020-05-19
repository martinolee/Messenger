//
//  AccountError.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/18.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation

public enum UserCreationError: Error {
  case emptyForm
  case noResult
  case firebaseError(Error)
  
  var localizedDescription: String {
    switch self {
    case .emptyForm:
      return "Probably missing name, email or password"
    case .noResult:
      return "Has no result"
    case .firebaseError(let error):
      return error.localizedDescription
    }
  }
}
