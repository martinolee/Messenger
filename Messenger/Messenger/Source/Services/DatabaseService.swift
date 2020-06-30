//
//  DatabaseService.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/20.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation
import FirebaseFirestore

public final class DatabaseService {
  static let shared = DatabaseService()
  
  let usersDB = Firestore.firestore().collection("users")
  
  func addNewUser(uid: String, name: String, email: String, completionHandler: @escaping (Error?) -> Void) {
    let userData = User(
      uid: uid,
      name: name,
      email: email,
      profileImageURL: nil,
      profileCoverImageURL: nil,
      statusMessage: nil,
      friends: [],
      messages: []
    ).asDictionary
    
    self.usersDB.document(uid).setData(userData, merge: true) { error in
      completionHandler(error)
    }
  }
  
  private init() { }
}
