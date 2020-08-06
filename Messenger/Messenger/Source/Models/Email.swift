//
//  Email.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/08/04.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation


typealias Email = String

extension Email {
  var isValidEmail: Bool {
    let validEmailForm = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", validEmailForm)
    
    return emailPredicate.evaluate(with: self)
  }
}
