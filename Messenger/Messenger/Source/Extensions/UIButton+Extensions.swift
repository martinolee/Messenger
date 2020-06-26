//
//  UIButton+Extensions.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/19.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit.UIButton

extension UIButton {
  func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
    UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
    
    if let context = UIGraphicsGetCurrentContext() {
      context.setFillColor(color.cgColor)
      context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
      let colorImage = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      self.setBackgroundImage(colorImage, for: state)
    }
  }
}
