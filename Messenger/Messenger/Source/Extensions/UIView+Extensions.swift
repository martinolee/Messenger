//
//  UIView+Extensions.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/16.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit.UIView

extension UIView {
  func addSubviews(_ views: [UIView]) {
    views.forEach { self.addSubview($0) }
  }
  
  func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    tap.cancelsTouchesInView = false
    self.addGestureRecognizer(tap)
  }
  
  @objc
  fileprivate func dismissKeyboard() {
    self.endEditing(true)
  }
}
