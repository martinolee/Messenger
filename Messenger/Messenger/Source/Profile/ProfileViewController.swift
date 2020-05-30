//
//  ProfileViewController.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/23.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation

final class ProfileViewController: BaseViewController, View {
  // MARK: - Properties
  
  let profileView = ProfileView()
  
  
  // MARK: - Life Cycle
  
  init(reactor: ProfileViewReactor) {
    super.init()
    
    self.reactor = reactor
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
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
    view.addSubview(profileView)
    profileView.snp.makeConstraints { $0.edges.equalToSuperview() }
  }
  
  func setUpNavigation() {
    guard let navigationController = self.navigationController else { return }
    navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController.navigationBar.shadowImage = UIImage()
    navigationController.navigationBar.isTranslucent = true
    navigationController.view.backgroundColor = .clear
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileView.backButton)
  }
  
  
  // MARK: - Binding
  
  func bind(reactor: ProfileViewReactor) {
    // Action
    
    profileView.backButton.rx.tap
      .subscribe(onNext: { [weak self] in
        guard let self = self else { return }
        
        self.dismiss(animated: true)
      })
      .disposed(by: disposeBag)
    
    // State
    
    reactor.state.map { $0.user.profileCoverImageURL }
      .distinctUntilChanged()
      .subscribe(onNext: { [weak self] profileCoverImageURL in
        guard let self = self else { return }
        
        self.profileView.profileCoverImageView.kf.setImage(with: profileCoverImageURL)
      })
      .disposed(by: disposeBag)
    
    reactor.state.map { $0.user.profileImageURL }
      .distinctUntilChanged()
      .subscribe(onNext: { [weak self] profileImageURL in
        guard let self = self else { return }
        
        self.profileView.profileImageView.kf.setImage(with: profileImageURL, placeholder: UIImage(systemName: "person.crop.square"))
      })
      .disposed(by: disposeBag)
    
    reactor.state.map { $0.user.name }
      .distinctUntilChanged()
      .bind(to: profileView.nameLabel.rx.text)
      .disposed(by: disposeBag)
    
    reactor.state.map { $0.user.statusMessage }
      .filterNil()
      .distinctUntilChanged()
      .bind(to: profileView.statusMessageLabel.rx.text)
      .disposed(by: disposeBag)
  }
}
