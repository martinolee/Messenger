//
//  AddFriendsViewController.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/20.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

final class AddFriendsViewController: BaseViewController, View {
  // MARK: - Properties
  
  let addFriendsView = AddFriendsView()
  
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpAttribute()
    setUpRootView()
    setUpNavigation()
  }
  
  // MARK: - Setup
  
  override func setUpAttribute() {
  }
  
  override func setUpRootView() {
    self.reactor = AddFriendsViewReactor()
    
    view.addSubview(addFriendsView)
    addFriendsView.snp.makeConstraints { $0.edges.equalToSuperview() }
  }
  
  func setUpNavigation() {
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: addFriendsView.cancelButton)
    navigationItem.title = "Add friends".localized
  }
  
  func bind(reactor: AddFriendsViewReactor) {
    // MARK: - Action
    
    addFriendsView.cancelButton.rx.tap
      .subscribe(onNext: { [weak self] in
        guard let self = self else { return }
        
        self.dismiss(animated: true)
      })
      .disposed(by: disposeBag)
    
    addFriendsView.friendsEmailTextField.rx.text.changed
      .filterNil()
      .distinctUntilChanged()
      .map { Reactor.Action.updateEmail($0) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    addFriendsView.friendsEmailTextField.rx.controlEvent(.primaryActionTriggered)
      .map { Reactor.Action.searchFriend }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    addFriendsView.searchFriendButton.rx.tap
      .map { Reactor.Action.searchFriend }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    addFriendsView.addFriendButton.rx.tap
      .map { Reactor.Action.addFriend }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    // MARK: - State
    
    reactor.state.map { !$0.isSearchingUser }
      .distinctUntilChanged()
      .bind(to: addFriendsView.dimView.rx.isHidden)
      .disposed(by: disposeBag)
    
    reactor.state.map { $0.isSearchingUser }
      .distinctUntilChanged()
      .bind(to: addFriendsView.activityIndicatorView.rx.isAnimating)
      .disposed(by: disposeBag)
    
    reactor.state.map { $0.email?.isValidEmail ?? false }
      .distinctUntilChanged()
      .bind(to: addFriendsView.searchFriendButton.rx.isEnabled)
      .disposed(by: disposeBag)
    
    reactor.state.map { $0.searchingError }
      .filterNil()
      .distinctUntilChanged()
      .subscribe(onNext: { [weak self] error in
        guard let self = self else { return }
        guard let error = error.error as? FriendsError else { return }
        
        self.addFriendsView.userProfileImageView.isHidden = true
        self.addFriendsView.userNameLabel.text = error.localizedDescription
        self.addFriendsView.addFriendButton.isHidden = true
      })
      .disposed(by: disposeBag)
    
    reactor.state.map { $0.searchedUser?.name }
      .filterNil()
      .distinctUntilChanged()
      .bind(to: addFriendsView.userNameLabel.rx.text)
      .disposed(by: disposeBag)
    
    reactor.state.map { $0.searchedUser }
      .filterNil()
      .distinctUntilChanged()
      .subscribe(onNext: { [weak self] user in
        guard let self = self else { return }
        
        self.addFriendsView.userProfileImageView.isHidden = false
        self.addFriendsView.userNameLabel.isHidden = false
        self.addFriendsView.addFriendButton.isHidden = false
      })
      .disposed(by: disposeBag)
    
    reactor.state.map { !$0.isAddingFriend }
      .distinctUntilChanged()
      .bind(to: addFriendsView.dimView.rx.isHidden)
      .disposed(by: disposeBag)
    
    reactor.state.map { $0.isAddingFriend }
      .distinctUntilChanged()
      .bind(to: addFriendsView.activityIndicatorView.rx.isAnimating)
      .disposed(by: disposeBag)
  }
}
