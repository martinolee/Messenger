//
//  FriendsView.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/19.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

final class FriendsView: UIView, ViewSetup {
  // MARK: - Properties
  
  let addFriendsButton = UIButton(type: .system).then {
    $0.setImage(UIImage(systemName: "person.crop.circle.badge.plus"), for: .normal)
    $0.setImage(UIImage(systemName: "person.crop.circle.fill.badge.plus"), for: .highlighted)
    $0.tintColor = .systemOrange
  }
  
  let friendsTableView = UITableView().then {
    $0.separatorStyle = .none
    $0.tableFooterView = UIView()
    
    $0.register(cell: FriendCell.self)
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
      friendsTableView,
    ])
  }
  
  func setUpLayout() {
    friendsTableView.snp.makeConstraints { $0.edges.equalToSuperview() }
  }
}
