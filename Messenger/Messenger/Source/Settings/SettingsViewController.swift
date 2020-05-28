//
//  SettingsViewController.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/19.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit
import FirebaseAuth

final class SettingsViewController: BaseViewController, View {
  // MARK: - Properties
  
  let settingsView = SettingsView()
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpAttribute()
    setUpRootView()
  }
  
  // MARK: - Setup
  
  override func setUpAttribute() {
    self.title = TabBar.settings.title.localized
  }
  
  override func setUpRootView() {
    self.reactor = SettingsViewReactor()
    
    view.addSubview(settingsView)
    settingsView.snp.makeConstraints { $0.edges.equalToSuperview() }
  }
  
  func setUpNavigation() {
    self.navigationItem.title = TabBar.settings.title.localized
  }
  
  func bind(reactor: SettingsViewReactor) {
    // MARK: - Action
    
    settingsView.settingsTableView.rx.itemSelected
      .subscribe(onNext: { indexPath in
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        switch indexPath.row {
        case Settings.logOut.id:
          do {
            try Auth.auth().signOut()
            
            appDelegate.setUpRootViewControllerForUserLoginCondition()
          } catch {
            print(error.localizedDescription)
          }
          
        case Settings.deleteAccount.id:
          AuthService.shared.deleteAccount { error in
            if let error = error {
              print(error.localizedDescription)
            } else {
              appDelegate.setUpRootViewControllerForUserLoginCondition()
            }
          }
          
        default:
          print("unidentified setting")
        }
      })
      .disposed(by: disposeBag)
    
    // MARK: - State
    
    reactor.state.map { $0.settings }
      .bind(to: settingsView.settingsTableView.rx.items(cellIdentifier: UITableViewCell.identifier)) { index, setting, cell in
        
        cell.textLabel?.text = setting.title.localized
        
    }.disposed(by: disposeBag)
  }
}
