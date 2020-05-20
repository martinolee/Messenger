//
//  UserAccountManager.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/18.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation
import FirebaseAuth

final public class UserAccountManager {
  public static let shared = UserAccountManager()
  
  public var isUserLoggedIn: Bool {
    Auth.auth().currentUser != nil
  }
  
  public func signUp(_ signupForm: SignupForm) -> Observable<Result<AuthDataResult, SignupError>> {
    guard
      let name = signupForm.name,
      let email = signupForm.email,
      let password = signupForm.password
    else { return .empty() }
    
    return Observable.create { observer in
      Auth.auth().createUser(withEmail: email, password: password) { result, error in
        guard error == nil else {
          observer.onNext(.failure(.firebaseError(error!)))
          observer.onCompleted()
          return
        }
        guard let result = result else {
          observer.onNext(.failure(.noResult))
          observer.onCompleted()
          return
        }
        
        let userUpdateRequest = result.user.createProfileChangeRequest()
        
        userUpdateRequest.displayName = name
        userUpdateRequest.commitChanges { error in
          if let error = error {
            observer.onNext(.failure(.firebaseError(error)))
          } else {
            observer.onNext(.success(result))
          }
          
          observer.onCompleted()
          return
        }
      }
      return Disposables.create()
    }
  }
  
  public func logIn(_ loginForm: LoginForm) -> Observable<Result<AuthDataResult, LoginError>> {
    guard let email = loginForm.email, let password = loginForm.password else { return Observable.just(.failure(.missingInfo)) }
    
    return Observable.create { observer in
      Auth.auth().signIn(withEmail: email, password: password) { result, error in
        if let error = error {
          observer.onNext(.failure(.firebaseError(error)))
        } else if let result = result {
          observer.onNext(.success(result))
        }
        
        observer.onCompleted()
        return
      }
      return Disposables.create()
    }
  }
  
  private init() { }
}
