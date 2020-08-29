//
//  FriendTableViewCell.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/23.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

final class FriendCell: BaseCell, View {
  // MARK: - Properties
  
  let profileImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
    $0.tintColor = .systemOrange
  }
  
  let nameLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 18, weight: .medium)
    $0.textAlignment = .left
  }
  
  let statusMessageLabel = UILabel().then {
    $0.textAlignment = .left
  }
  
  
  // MARK: - Life Cycle
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setUpAttribute()
    addAllSubviews()
    setUpLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: - Setup UI
  
  override func setUpAttribute() {
    self.backgroundColor = .systemBackground
  }
  
  override func addAllSubviews() {
    contentView.addSubviews([
      profileImageView,
      nameLabel,
      statusMessageLabel,
    ])
  }
  
  override func setUpLayout() {
    let safeArea = contentView.safeAreaLayoutGuide
    
    profileImageView.snp.makeConstraints {
      $0.top.leading.bottom.equalTo(safeArea).inset(8)
      $0.trailing.equalTo(nameLabel.snp.leading).offset(-8)
      $0.size.equalTo(50)
    }
    
    nameLabel.snp.makeConstraints {
      $0.top.equalTo(profileImageView)
      $0.bottom.equalTo(profileImageView.snp.centerY).priority(.required)
      $0.centerY.equalTo(profileImageView).priority(.medium)
      $0.trailing.equalTo(safeArea).inset(8)
    }
    
    statusMessageLabel.snp.makeConstraints {
      $0.top.equalTo(profileImageView.snp.centerY)
      $0.leading.trailing.equalTo(nameLabel)
      $0.bottom.equalTo(profileImageView)
    }
  }
  
  
  // MARK: Binding
  
  func bind(reactor: FriendCellReactor) {
    // State
    
    reactor.state.map { $0.profileImageURL }
      .distinctUntilChanged()
      .subscribe(onNext: { [weak self] profileImageURL in
        guard let self = self else { return }
        
        self.profileImageView.kf.setImage(
          with: profileImageURL,
          placeholder: UIImage(systemName: "person.crop.square")
        )
      })
      .disposed(by: disposeBag)
    
    reactor.state.map { $0.name }
      .distinctUntilChanged()
      .bind(to: nameLabel.rx.text)
      .disposed(by: disposeBag)
    
    reactor.state.map { $0.statusMessage }
      .distinctUntilChanged()
      .subscribe(onNext: { [weak self] statusMessage in
        guard let self = self else { return }
        
        if let statusMessage = statusMessage {
          self.statusMessageLabel.text = statusMessage
        } else {
          print("no status message")
        }
      })
      .disposed(by: disposeBag)
  }
}
