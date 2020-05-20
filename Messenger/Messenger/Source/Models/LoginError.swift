//
//  LoginError.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/19.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation

public enum LoginError: Error {
  case missingInfo
  case firebaseError(Error)
  
  var localizedDescription: String {
    switch self {
    case .missingInfo:
      return "Probaly missing email or password"
    case .firebaseError(let error):
      return error.localizedDescription
    }
  }
}
