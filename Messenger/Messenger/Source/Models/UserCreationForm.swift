//
//  UserCreationForm.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/18.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation

public struct UserCreationForm {
  var name: String?
  var email: String?
  var password: String?
}

extension UserCreationForm {
  var isFullyFormed: Bool {
    isNameEntered && isEmailEntered && isPasswordEntered && hasValidEmail && hasValidPassword
  }
  
  var isNameEntered: Bool {
    guard let name = name else { return false }
    
    return !name.isEmpty
  }
  
  var isEmailEntered: Bool {
    guard let email = email else { return false }
    
    return !email.isEmpty
  }
  
  var isPasswordEntered: Bool {
    guard let password = password else { return false }
    
    return !password.isEmpty
  }
  
  var hasValidEmail: Bool {
    email?.isValidEmail ?? false
  }
  
  var hasValidPassword: Bool {
    guard let password = password else { return false }
    
    return password.count >= 6
  }
}
