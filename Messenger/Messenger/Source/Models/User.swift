//
//  User.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/21.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation

struct User {
  let uid: String
  let name: String
  let email: String
  let profileImageURL: URL?
  let profileCoverImageURL: URL?
  let statusMessage: String?
  let friends: [String]
  let messages: [String]
}

extension User {
  init?(_ dictionary: [String: Any]) {
    guard
      let uid = dictionary["uid"] as? String,
      let name = dictionary["name"] as? String,
      let email = dictionary["email"] as? String,
      let friends = dictionary["friends"] as? [String],
      let messages = dictionary["messages"] as? [String]
    else { return nil }
    
    self.uid = uid
    self.name = name
    self.email = email
    self.statusMessage = dictionary["statusMessage"] as? String
    self.profileImageURL = URL(string: dictionary["profileImageURL"] as? String ?? "")
    self.profileCoverImageURL = URL(string: dictionary["profileCoverImageURL"] as? String ?? "")
    self.friends = friends
    self.messages = messages
  }
}

extension User {
  var asDictionary: [String: Any] {
    [
      "uid": uid,
      "name": name,
      "email": email,
      "profileImageURL": profileImageURL as Any,
      "profileCoverImageURL": profileCoverImageURL as Any,
      "statusMessage": statusMessage as Any,
      "friends": friends,
      "messages": messages,
    ]
  }
}

extension User: Equatable {
  static func == (lhs: User, rhs: User) -> Bool {
    lhs.uid == rhs.uid
  }
}
