//
//  MSButton.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/07/16.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

class MSButton: UIButton {
  
  // MARK: - Constants
  
  private enum Color {
    static let normalTitle = UIColor.white
    
    static let disabledTitle = UIColor.white.withAlphaComponent(0.5)
    
    static var highlightedTitle: UIColor {
      normalTitle.withAlphaComponent(0.5)
    }
    
    static let normalBackground = UIColor.systemOrange
    
    static let disabledBackground = UIColor.lightGray
    
    static var highlightedBackground: UIColor {
      normalBackground.withAlphaComponent(0.5)
    }
  }
  
  
  // MARK: - Initalization
  
  init() {
    super.init(frame: .zero)
    
    self.setTitleColor(Color.normalTitle, for: .normal)
    self.setTitleColor(Color.disabledTitle, for: .disabled)
    self.setTitleColor(Color.highlightedTitle, for: .highlighted)
    self.setBackgroundColor(Color.normalBackground, for: .normal)
    self.setBackgroundColor(Color.disabledBackground, for: .disabled)
    self.setBackgroundColor(Color.highlightedBackground, for: .highlighted)
  }
  
  convenience init(title: String? = nil) {
    self.init()
    
    self.setTitle(title, for: .normal)
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
