//
//  RevsionedError.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/23.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation

struct RevisionedError: Error, Equatable {
  let revision: UInt
  let error: Error
}

extension RevisionedError {
  static func == (lhs: RevisionedError, rhs: RevisionedError) -> Bool {
    lhs.revision == rhs.revision
  }
}
