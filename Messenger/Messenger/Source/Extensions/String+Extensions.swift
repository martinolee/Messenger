//
//  String+Extensions.swift
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
  
  var hasWhiteSpace: Bool {
    let whitespace = " "
    
    return self.hasPrefix(whitespace) || self.hasSuffix(whitespace)
  }
}
