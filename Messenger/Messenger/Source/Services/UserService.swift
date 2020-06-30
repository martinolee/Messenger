//
//  UserService.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/20.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

public final class UserService {
  static let shared = UserService()
  
  private let auth = Auth.auth()
  
  let usersDB = DatabaseService.shared.usersDB
  
  func getUser(byEmail email: String) -> Observable<User> {
    return Observable.create { observer in
      self.usersDB.whereField("email", isEqualTo: email).getDocuments { snapshot, error in
        if let error = error {
          observer.onError(error)
        } else if let userDictionary = snapshot?.documents.first?.data(), let user = User(userDictionary) {
          observer.onNext(user)
        } else {
          observer.onError(FriendsError.userNotFound)
        }
        
        observer.onCompleted()
        return
      }
      return Disposables.create()
    }
  }
  
  func getUser(byUID uid: String) -> Observable<User> {
    return Observable.create { observer in
      self.usersDB.document(uid).getDocument { snapshot, error in
        if let error = error {
          observer.onError(error)
        } else if let userDictionary = snapshot?.data(), let user = User(userDictionary) {
          observer.onNext(user)
        } else {
          observer.onError(FriendsError.userNotFound)
        }
        
        observer.onCompleted()
        return
      }
      return Disposables.create()
    }
  }
  
  func addFriend(byUID userUID: String) -> Observable<String> {
    return Observable.create { observer in
      if let currentUserUID = self.auth.currentUser?.uid {
        self.usersDB.document(currentUserUID).updateData([
          "friends": FieldValue.arrayUnion([userUID])
        ]) { error in
          if let error = error {
            observer.onError(error)
          } else {
            observer.onNext(userUID)
          }

          observer.onCompleted()
        }
      } else {
        observer.onError(FriendsError.userNotFound)
        observer.onCompleted()
      }
      
      return Disposables.create()
    }
  }
  
  func fetchFriendUIDs() -> Observable<[String]> {
    return Observable.create { observer in
      if let currentUserUID = self.auth.currentUser?.uid {
        self.usersDB.document(currentUserUID).getDocument { snapshot, error in
          if let error = error {
            observer.onError(error)
          } else if let userDictionary = snapshot?.data(), let user = User(userDictionary) {
            observer.onNext(user.friends)
          }
          
          observer.onCompleted()
        }
      } else {
        observer.onError(FriendsError.userNotFound)
        observer.onCompleted()
      }
      
      return Disposables.create()
    }
  }
  
  private init() { }
}
