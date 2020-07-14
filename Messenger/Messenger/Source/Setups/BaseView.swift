//
//  BaseView.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/28.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

class BaseView: UIView {
  
  // MARK: - Initialization
  
  init() {
    super.init(frame: .zero)
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
