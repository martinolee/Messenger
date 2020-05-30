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
  }
  
  enum Mutation {
    case setFetchingFriendUIDs(Bool)
    
    case setFriendUIDs([String])
  }
  
  struct State {
    var isFetchingFriendUIDs: Bool
    
    var friendUIDs: [String]
  }
  
  let initialState: State
  
  init() {
    self.initialState = State(isFetchingFriendUIDs: false, friendUIDs: [])
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .fetchFriendUIDs:
      guard !currentState.isFetchingFriendUIDs else { return .empty() }
      
      return Observable.concat([
        Observable.just(.setFetchingFriendUIDs(true)),
        
        FriendsService.shared.fetchFriendUIDs()
          .map(Mutation.setFriendUIDs),
        
        Observable.just(.setFetchingFriendUIDs(false)),
      ])
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    
    switch mutation {
    case .setFetchingFriendUIDs(let isFetchingFriendUIDs):
      state.isFetchingFriendUIDs = isFetchingFriendUIDs
      
    case .setFriendUIDs(let friendUIDs):
      state.friendUIDs = friendUIDs
    }
    
    return state
  }
}

extension FriendsViewReactor {
  func reactorForProfile(_ friendCellReactor: FriendCellReactor) -> ProfileViewReactor {
    let friend = friendCellReactor.currentState.friend
    
    return ProfileViewReactor(user: friend)
  }
}
