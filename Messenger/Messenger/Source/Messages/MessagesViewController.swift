//
//  MessagesViewController.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/19.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

final class MessagesViewController: BaseViewController, View {
  // MARK: - Properties
  
  let messagesView = MessagesView()
  
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpAttribute()
    setUpRootView()
  }
  
  func setUpAttribute() {
    self.title = TabBar.messages.title.localized
  }
  
  func setUpRootView() {
    self.reactor = MessagesViewReactor()
    
    view.addSubview(messagesView)
    messagesView.snp.makeConstraints { $0.edges.equalToSuperview() }
  }
  
  func setUpNavigation() {
    self.navigationItem.title = TabBar.messages.title.localized
  }
  
  func bind(reactor: MessagesViewReactor) {
  }
}
