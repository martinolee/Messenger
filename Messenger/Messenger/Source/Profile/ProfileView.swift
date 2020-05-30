//
//  ProfileView.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/23.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

class ProfileView: UIView, ViewSetup {
  // MARK: - Properties
  
  let backButton = UIButton(type: .system).then {
    $0.tintColor = .systemOrange
    $0.setImage(UIImage(systemName: "xmark"), for: .normal)
  }
  
  let profileCoverImageView = UIImageView()
  
  let containerView = UIView().then {
    $0.backgroundColor = .systemBackground
  }
  
  let profileImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
    $0.tintColor = .systemOrange
  }
  
  let nameLabel = UILabel().then {
    $0.textAlignment = .center
    $0.numberOfLines = 1
    $0.font = .systemFont(ofSize: 28, weight: .medium)
    $0.setContentHuggingPriority(.required, for: .vertical)
  }
  
  let statusMessageLabel = UILabel().then {
    $0.textAlignment = .center
    $0.numberOfLines = 4
    $0.setContentHuggingPriority(.fittingSizeLevel, for: .vertical)
  }
  
  let chatButton = UIButton(type: .system).then {
    $0.clipsToBounds = true
    $0.layer.cornerRadius = 6
    
    $0.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
    
    $0.setTitle("Chat".localized, for: .normal)
    
    $0.setTitleColor(.white, for: .normal)
    $0.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .disabled)
    
    $0.setBackgroundColor(.systemOrange, for: .normal)
    $0.setBackgroundColor(.lightGray, for: .disabled)
  }
  
  let panGestureRecognizer = UIPanGestureRecognizer()
  
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
      profileCoverImageView,
      containerView,
    ])
    
    containerView.addSubviews([
      profileImageView,
      nameLabel,
      statusMessageLabel,
      chatButton
    ])
  }
  
  func setUpLayout() {
    let safeArea = self.safeAreaLayoutGuide
      
    profileCoverImageView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
    }
    
    containerView.snp.makeConstraints {
      $0.top.equalTo(profileCoverImageView.snp.bottom)
      $0.leading.trailing.equalTo(profileCoverImageView)
      $0.bottom.equalToSuperview()
      $0.height.equalTo(320)
    }
    
    profileImageView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(16)
      $0.centerX.equalToSuperview()
      $0.size.equalTo(80)
    }
    
    nameLabel.snp.makeConstraints {
      $0.top.equalTo(profileImageView.snp.bottom).offset(16)
      $0.leading.trailing.equalToSuperview().inset(16)
      $0.height.equalTo(24)
    }
    
    statusMessageLabel.snp.makeConstraints {
      $0.top.equalTo(nameLabel.snp.bottom).offset(16)
      $0.leading.trailing.equalTo(nameLabel).inset(16)
    }
    
    chatButton.snp.makeConstraints {
      $0.top.equalTo(statusMessageLabel.snp.bottom).offset(16)
      $0.leading.trailing.equalToSuperview().inset(16)
      $0.height.equalTo(50)
      $0.bottom.equalTo(safeArea)
    }
  }
}
