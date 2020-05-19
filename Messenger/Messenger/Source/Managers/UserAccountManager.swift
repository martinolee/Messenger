//
//  UserCreationManager.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/18.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation
import FirebaseAuth

final public class UserAccountManager {
  public static let shared = UserAccountManager()
  
  public func creatUser(_ userCreationForm: UserCreationForm) -> Observable<Result<AuthDataResult,UserCreationError>> {
    guard
      let name = userCreationForm.name,
      let email = userCreationForm.email,
      let password = userCreationForm.password
    else { return .empty() }
    
    return Observable.create { observer in
      Auth.auth().createUser(withEmail: email, password: password) { result, error in
        guard error == nil else { return observer.onNext(.failure(.firebaseError(error!))) }
        guard let result = result else { return observer.onNext(.failure(.noResult)) }
        
        let userUpdateRequest = result.user.createProfileChangeRequest()
        
        userUpdateRequest.displayName = name
        userUpdateRequest.commitChanges { error in
          guard error == nil else { return observer.onError(error!) }
          
          observer.onNext(.success(result))
          observer.onCompleted()
          return
        }
      }
      return Disposables.create()
    }
  }
  
  private init() { }
}
