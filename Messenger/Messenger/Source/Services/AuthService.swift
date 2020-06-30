//
//  AuthService.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/18.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation
import FirebaseAuth

public final class AuthService {
  public static let shared = AuthService()
  
  private let auth = Auth.auth()
  
  private let userDB = DatabaseService.shared.usersDB
  
  public var isUserLoggedIn: Bool {
    auth.currentUser != nil
  }
  
  public func signUp(name: String, email: String, password: String) -> Observable<AuthDataResult> {
    return Observable.create { observer in
      self.auth.createUser(withEmail: email, password: password) { result, error in
        if let error = error {
          observer.onError(error)
        } else if let result = result {
          observer.onNext(result)
          
          DatabaseService.shared.addNewUser(uid: result.user.uid, name: name, email: email) { error in
            if let error = error {
              observer.onError(error)
            }
          }
        }
        
        observer.onCompleted()
        return
      }
      return Disposables.create()
    }
  }
  
  public func logIn(email: String, password: String) -> Observable<AuthDataResult> {
    return Observable.create { observer in
      self.auth.signIn(withEmail: email, password: password) { result, error in
        if let error = error {
          observer.onError(error)
        } else if let result = result {
          observer.onNext(result)
        }
        
        observer.onCompleted()
        return
      }
      return Disposables.create()
    }
  }
  
  public func logOut() throws {
    try auth.signOut()
  }
  
  public func deleteAccount(completionHandler: @escaping (Error?) -> Void) {
    guard let uid = auth.currentUser?.uid else { return }
    
    userDB.document(uid).delete { error in
      if let error = error { completionHandler(error) }

      self.auth.currentUser?.delete(completion: { error in
        completionHandler(error)
      })
    }
  }
  
  private init() { }
}
