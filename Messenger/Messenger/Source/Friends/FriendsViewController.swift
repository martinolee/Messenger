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
  
  func bind(reactor: FriendsViewReactor) {
    // MARK: - Action
    
    Observable.just(Void())
      .map { Reactor.Action.fetchFriendUIDs }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    friendsView.addFriendsButton.rx
      .tap
      .subscribe(onNext: { [weak self] in
        guard let self = self else { return }
        let addFriendsViewController = UINavigationController(rootViewController: AddFriendsViewController())
        
        self.present(addFriendsViewController, animated: true)
      })
      .disposed(by: disposeBag)
    
    friendsView.friendsTableView.rx
      .itemSelected
      .subscribe(onNext: { [weak self] index in
        guard let self = self else { return }
        let navigationViewController = UINavigationController(rootViewController: ProfileViewController().then {
          $0.reactor = ProfileViewReactor()
        }).then {
          $0.modalPresentationStyle = .fullScreen
        }
        
        self.present(navigationViewController, animated: true)
        self.friendsView.friendsTableView.deselectRow(at: index, animated: true)
      })
      .disposed(by: disposeBag)
    
    // MARK: - State
    
    reactor.state
      .map { $0.friendUIDs }
      .distinctUntilChanged()
      .bind(to: friendsView.friendsTableView.rx.items(cellIdentifier: FriendCell.identifier, cellType: FriendCell.self)) { [weak self] row, uid, cell in
        guard self != nil else { return }
        
        FriendsService.shared.usersDB.document(uid).getDocument { snapshot, error in
          guard error == nil, let friendDictionary = snapshot?.data(), let friend = User(friendDictionary) else { return }
          
          cell.reactor = FriendCellReactor(friend: friend)
        }
    }.disposed(by: disposeBag)
  }
}
