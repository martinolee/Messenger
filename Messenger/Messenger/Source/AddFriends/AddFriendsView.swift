//
//  AddFriendsView.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/20.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

final class AddFriendsView: UIView, ViewSetup {
  // MARK: - Properties
  
  let dimView = UIView().then {
    $0.isHidden = true
    $0.backgroundColor = UIColor.black.withAlphaComponent(0.5)
  }
  
  let activityIndicatorView = UIActivityIndicatorView().then {
    $0.hidesWhenStopped = true
    $0.style = .large
    $0.color = .systemOrange
  }
  
  let cancelButton = UIButton(type: .system).then {
    $0.setImage(UIImage(systemName: "xmark"), for: .normal)
    $0.tintColor = .systemOrange
  }
  
  let friendsEmailTextField = UITextField().then {
    $0.autocorrectionType = .no
    $0.autocapitalizationType = .none
    $0.keyboardType = .emailAddress
    $0.returnKeyType = .search
    $0.placeholder = "Friend's email".localized
  }
  
  let searchFriendButton = UIButton(type: .system).then {
    $0.clipsToBounds = true
    $0.layer.cornerRadius = 6
    
    $0.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
    
    $0.setTitle("Search".localized, for: .normal)
    
    $0.setTitleColor(.white, for: .normal)
    $0.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .disabled)
    
    $0.setBackgroundColor(.systemOrange, for: .normal)
    $0.setBackgroundColor(.lightGray, for: .disabled)
  }
  
  // MARK: - Life Cycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setUpAttribute()
    addAllSubviews()
    setUpLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - UI Setup
  
  func setUpAttribute() {
    self.backgroundColor = .systemBackground
  }
  
  func addAllSubviews() {
    self.addSubviews([
      friendsEmailTextField,
      searchFriendButton,
      dimView
    ])
    
    dimView.addSubview(activityIndicatorView)
  }
  
  func setUpLayout() {
    let safeArea = safeAreaLayoutGuide
    
    dimView.snp.makeConstraints { $0.edges.equalToSuperview() }
    
    activityIndicatorView.snp.makeConstraints { $0.center.equalToSuperview() }
    
    friendsEmailTextField.snp.makeConstraints {
      $0.top.equalTo(safeArea).offset(16)
      $0.leading.trailing.equalTo(safeArea).inset(16)
      $0.height.equalTo(50)
    }
    
    searchFriendButton.snp.makeConstraints {
      $0.top.equalTo(friendsEmailTextField.snp.bottom).offset(8)
      $0.leading.trailing.equalTo(friendsEmailTextField)
      $0.height.equalTo(50)
    }
  }
}
