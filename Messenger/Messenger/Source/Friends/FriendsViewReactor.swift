//
//  FriendsViewReactor.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/19.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation

final class FriendsViewReactor: Reactor {
  enum Action {
    case fetchFriendUIDs
    
    case updateFriendAt(Int, String)
  }
  
  enum Mutation {
    case setFetchingFriendUIDs(Bool)
    
    case setFriendUIDs([String])
    
    case setUpdatingFriends((index: Int, value: Bool))
    
    case setFriend(Int, User)
  }
  
  struct State {
    var isFetchingFriendUIDs: Bool
    
    var updatingFriends: [(index: Int, value: Bool)]
    
    var friends: [Any]
  }
  
  let initialState: State
  
  init() {
    self.initialState = State(
      isFetchingFriendUIDs: false,
      updatingFriends: [],
      friends: []
    )
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .fetchFriendUIDs:
      guard !currentState.isFetchingFriendUIDs else { return .empty() }
      
      return Observable.concat([
        Observable.just(.setFetchingFriendUIDs(true)),
        
        UserManager.shared.fetchFriendUIDs()
          .map(Mutation.setFriendUIDs),
        
        Observable.just(.setFetchingFriendUIDs(false)),
      ])
      
    case .updateFriendAt(let index, let friendUID):
      guard
        !currentState.updatingFriends.contains(where: { $0.index == index })
      else { return .empty() }
      
      return Observable.concat([
        Observable.just(.setUpdatingFriends((index, true))),
        
        UserManager.shared.getUser(byUID: friendUID)
          .map { Mutation.setFriend(index, $0) },
        
        Observable.just(.setUpdatingFriends((index, false))),
      ])
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    
    switch mutation {
    case .setFetchingFriendUIDs(let isFetchingFriendUIDs):
      state.isFetchingFriendUIDs = isFetchingFriendUIDs
      
    case .setFriendUIDs(let friendUIDs):
      state.friends = friendUIDs
      
    case .setUpdatingFriends(let updatingFriend):
      state.updatingFriends.append(updatingFriend)
      
      if updatingFriend.value == false {
        state.updatingFriends = state.updatingFriends
          .filter { $0.index != updatingFriend.index }
      }
      
    case .setFriend(let index, let friend):
      state.friends[index] = friend
    }
    
    return state
  }
}

extension FriendsViewReactor {
  func reactorForProfile(_ friendCellReactor: FriendCellReactor) -> ProfileViewReactor {
    let friend = friendCellReactor.currentState
    
    return ProfileViewReactor(user: friend)
  }
}
