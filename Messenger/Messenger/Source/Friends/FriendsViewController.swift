//
//  FriendsViewController.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/19.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

final class FriendsViewController: BaseViewController, View {
  // MARK: - Properties
  
  let friendsView = FriendsView()
  
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpAttribute()
    setUpRootView()
    setUpNavigation()
  }
  
  
  // MARK: - Setup
  
  override func setUpAttribute() {
    self.title = TabBar.friends.title.localized
  }
  
  override func setUpRootView() {
    self.reactor = FriendsViewReactor()
    
    view.addSubview(friendsView)
    friendsView.snp.makeConstraints { $0.edges.equalToSuperview() }
  }
  
  func setUpNavigation() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: friendsView.addFriendsButton)
  }
  
  
  // MARK: - Binding
  
  func bind(reactor: FriendsViewReactor) {
    // Action
    
    Observable.just(Void())
      .map { Reactor.Action.fetchFriendUIDs }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    friendsView.addFriendsButton.rx.tap
      .subscribe(onNext: { [weak self] in
        guard let self = self else { return }
        let addFriendsViewController = NavigationController(AddFriendsViewController())
        
        self.present(addFriendsViewController, animated: true)
      })
      .disposed(by: disposeBag)
    
    friendsView.friendsTableView.rx.itemSelected
      .subscribe(onNext: { [weak self] index in
        guard
          let self = self,
          let friendCellReactor = (self.friendsView.friendsTableView.cellForRow(at: index) as? FriendCell)?.reactor
        else { return }
        let profileViewReactor = reactor.reactorForProfile(friendCellReactor)
        
        let viewController = ProfileViewController(reactor: profileViewReactor)
        let navigationController = NavigationController(viewController).then {
          $0.modalPresentationStyle = .fullScreen
        }
        
        self.present(navigationController, animated: true)
        self.friendsView.friendsTableView.deselectRow(at: index, animated: true)
      })
      .disposed(by: disposeBag)
    
    // State
      
    reactor.state.map { $0.friends }
      .bind(to: friendsView.friendsTableView.rx.items(
        cellIdentifier: FriendCell.identifier,
        cellType: FriendCell.self)
      ) { [weak self] index, friend, cell in
        guard let self = self else { return }
        
        if let friendUID = friend as? String {
          Observable.just(Void())
            .map { Reactor.Action.updateFriendAt(index, friendUID) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        } else if let friend = friend as? User {
          cell.reactor = FriendCellReactor(friend: friend)
        }
    }.disposed(by: disposeBag)
  }
}
