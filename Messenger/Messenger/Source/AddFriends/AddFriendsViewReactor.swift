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
    
    case addFriend
  }
  
  enum Mutation {
    case setEmail(String)
    
    case setSearchingUser(Bool)
    
    case setSearchingUserError(Error)
    
    case setSearchedUser(User)
    
    case setAddingFriend(Bool)
    
    case setAddingFriendError(Error)
    
    case setAddedFriend(String)
  }
  
  struct State {
    var email: String?
    
    var isSearchingUser: Bool
    
    var searchingError: RevisionedError?
    
    var searchedUser: User?
    
    var isAddingFriend: Bool
    
    var addingFriendError: RevisionedError?
    
    var addedFriend: String?
  }
  
  let initialState: State
  
  init() {
    self.initialState = State(isSearchingUser: false, isAddingFriend: false)
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .updateEmail(let email):
      return .just(.setEmail(email))
      
    case .searchFriend:
      guard !currentState.isSearchingUser, let email = currentState.email, email.isValidEmail else { return .empty() }
      
      return Observable.concat([
        Observable.just(.setSearchingUser(true)),
        
        FriendsService.shared.getUserInfo(byEmail: email)
          .map { .setSearchedUser($0) }
          .catchError { .just(.setSearchingUserError($0)) },
        
        Observable.just(.setSearchingUser(false)),
      ])
      
    case .addFriend:
      guard !currentState.isAddingFriend, let friendUID = currentState.searchedUser?.uid else { return .empty() }
      
      return Observable.concat([
        Observable.just(.setAddingFriend(true)),
        
        FriendsService.shared.addFriend(byUID: friendUID)
          .map { .setAddedFriend($0) }
          .catchError { .just(.setAddingFriendError($0)) },
          
        Observable.just(.setAddingFriend(false)),
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
      
    case .setSearchingUserError(let error):
      state.searchingError = RevisionedError(
        revision: (state.searchingError?.revision ?? 0) + 1,
        error: error
      )
      
    case .setSearchedUser(let searchedUser):
      state.searchedUser = searchedUser
      
    case .setAddingFriend(let isAddingFriend):
      state.isAddingFriend = isAddingFriend
      
    case .setAddingFriendError(let error):
      state.addingFriendError = RevisionedError(
        revision: (state.addingFriendError?.revision ?? 0) + 1,
        error: error
      )
      
    case .setAddedFriend(let addedFriend):
      state.addedFriend = addedFriend
    }
    
    return state
  }
}
