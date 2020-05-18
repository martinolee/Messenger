//
//  String+Additions.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/16.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation

extension String {
  var localized: String {
    NSLocalizedString(self, comment: "")
  }
  
  var isValidEmail: Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    
    return emailPred.evaluate(with: self)
  }
  
  var hasWhiteSpace: Bool {
    self.trimmingCharacters(in: .whitespaces).count != self.count
  }
}
