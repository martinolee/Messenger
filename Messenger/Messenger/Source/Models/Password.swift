//
//  Password.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/08/04.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation


typealias Password = String

extension Password {
  var isValidPassword: Bool {
    return self.count >= 6
  }
}
