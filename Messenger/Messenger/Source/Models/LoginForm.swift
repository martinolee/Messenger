//
//  LoginForm.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/19.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation

public struct LoginForm {
  var email: Email?
  
  var password: Password?
}

extension LoginForm {
  var hasValidForm: Bool {
    guard let email = email, email.isValidEmail, let password = password else { return false }
    
    return email.count > 0 && password.count >= 6
  }
}
