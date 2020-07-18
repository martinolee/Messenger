//
//  AddFriendsView.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/20.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

final class AddFriendsView: UIView, ViewSetup {
  
  // MARK: - Constants
  
  private enum Metric {
    static let padding = 16
    
    static let height = 50
  }
  
  private enum Font {
    static let searchFriendButton = UIFont.systemFont(ofSize: 24, weight: .bold)
    
    static let userNameLabel = UIFont.systemFont(ofSize: 22, weight: .medium)
    
    static let addFriendButton = UIFont.systemFont(ofSize: 18, weight: .bold)
  }
  
  private enum Color {
    static let dimViewBackground = UIColor.black.withAlphaComponent(0.5)
    
    static let activityIndicatorView = UIColor.systemOrange
    
    static let cancelButton = UIColor.systemOrange
    
    static let userProfileImageView = UIColor.systemOrange
  }
  
  
  // MARK: - Properties
  
  let dimView = UIView().then {
    $0.isHidden = true
    $0.backgroundColor = Color.dimViewBackground
  }
  
  let activityIndicatorView = UIActivityIndicatorView().then {
    $0.hidesWhenStopped = true
    $0.style = .large
    $0.color = Color.activityIndicatorView
  }
  
  let cancelButton = UIButton(type: .system).then {
    $0.setImage(UIImage(systemName: "xmark"), for: .normal)
    $0.tintColor = Color.cancelButton
  }
  
  let friendsEmailTextField = UITextField().then {
    $0.autocorrectionType = .no
    $0.autocapitalizationType = .none
    $0.keyboardType = .emailAddress
    $0.returnKeyType = .search
    $0.placeholder = "Friend's email".localized
  }
  
  let searchFriendButton = MSButton().then {
    $0.clipsToBounds = true
    $0.layer.cornerRadius = 6
    
    $0.titleLabel?.font = Font.searchFriendButton
    
    $0.setTitle("Search".localized, for: .normal)
  }
  
  let userProfileImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
    $0.image = UIImage(systemName: "person.crop.square")
    $0.tintColor = Color.userProfileImageView
    $0.isHidden = true
  }
  
  let userNameLabel = UILabel().then {
    $0.font = Font.userNameLabel
    $0.textAlignment = .center
  }
  
  let addFriendButton = MSButton().then {
    $0.clipsToBounds = true
    $0.layer.cornerRadius = 6
    
    $0.titleLabel?.font = Font.addFriendButton
    
    $0.setTitle("Add".localized, for: .normal)
    
    $0.isHidden = true
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
    self.hideKeyboardWhenTappedAround()
  }
  
  func addAllSubviews() {
    self.addSubviews([
      friendsEmailTextField,
      searchFriendButton,
      userProfileImageView,
      userNameLabel,
      addFriendButton,
      dimView,
    ])
    
    dimView.addSubviews([
      activityIndicatorView,
    ])
  }
  
  func setUpLayout() {
    let safeArea = safeAreaLayoutGuide
    
    dimView.snp.makeConstraints { $0.edges.equalToSuperview() }
    
    activityIndicatorView.snp.makeConstraints { $0.center.equalToSuperview() }
    
    friendsEmailTextField.snp.makeConstraints {
      $0.top.equalTo(safeArea).offset(Metric.padding)
      $0.leading.trailing.equalTo(safeArea).inset(Metric.padding)
      $0.height.equalTo(Metric.height)
    }
    
    searchFriendButton.snp.makeConstraints {
      $0.top.equalTo(friendsEmailTextField.snp.bottom).offset(Metric.padding)
      $0.leading.trailing.equalTo(friendsEmailTextField)
      $0.height.equalTo(Metric.height)
    }
    
    userProfileImageView.snp.makeConstraints {
      $0.top.equalTo(searchFriendButton.snp.bottom).offset(60)
      $0.centerX.equalTo(searchFriendButton)
      $0.size.equalTo(150)
    }
    
    userNameLabel.snp.makeConstraints {
      $0.top.equalTo(userProfileImageView.snp.bottom).offset(Metric.padding)
      $0.leading.trailing.equalTo(searchFriendButton)
      $0.height.equalTo(Metric.height)
    }
    
    addFriendButton.snp.makeConstraints {
      $0.top.equalTo(userNameLabel.snp.bottom).offset(Metric.padding)
      $0.centerX.equalTo(userNameLabel)
      $0.width.equalTo(80)
      $0.height.equalTo(Metric.height)
    }
  }
}
