//
//  AddFriendsViewReactor.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/20.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation

final class AddFriendsViewReactor: Reactor {
  enum Action {
    case updateEmail(String)
    
    case searchFriend
  }
  
  enum Mutation {
    case setEmail(String)
    
    case setSearchingUser(Bool)
    
    case setSearchResult(Result<[String: Any], AddFriendsError>)
  }
  
  struct State {
    var email: String?
    
    var searcheResult: Result<[String: Any], AddFriendsError>?
    
    var isSearchingUser: Bool
  }
  
  let initialState: State
  
  init() {
    self.initialState = State(isSearchingUser: false)
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .updateEmail(let email):
      return .just(.setEmail(email))
      
    case .searchFriend:
      guard !currentState.isSearchingUser, let email = currentState.email, email.isValidEmail else { return .empty() }
      
      return Observable.concat([
        Observable.just(.setSearchingUser(true)),
        
        FriendsManager.shared.getUserInfo(by: email)
          .map { .setSearchResult($0) },
        
        Observable.just(.setSearchingUser(false)),
      ])
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    
    switch mutation {
    case .setEmail(let email):
      state.email = email
      
    case .setSearchingUser(let isSearchingUser):
      state.isSearchingUser = isSearchingUser
      
    case .setSearchResult(let searcheResult):
      state.searcheResult = searcheResult
    }
    
    return state
  }
}
