//
//  MessagesView.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/19.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

final class MessagesView: UIView, ViewSetup {
  // MARK: - Properties
  
  let messagesTableView = UITableView().then {
    $0.tableFooterView = UIView()
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
      messagesTableView,
    ])
  }
  
  func setUpLayout() {
    messagesTableView.snp.makeConstraints { $0.edges.equalToSuperview() }
  }
}
