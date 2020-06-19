//
//  SignupForm.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/18.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation

public struct SignupForm {
  var name: String?
  
  var email: String?
  
  var password: String?
}

extension SignupForm {
  var isFullyFormed: Bool {
    isNameEntered && hasValidEmail && hasValidPassword
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
