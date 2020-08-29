//
//  CompositionRoot.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/08/27.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

#if DEBUG
import Gedatsu
#endif


final class CompositionRoot {
  static func resolve(for windowScene: UIWindowScene) -> AppDependency {
    let window = UIWindow(windowScene: windowScene)
    window.makeKeyAndVisible()
    
    return AppDependency(
      window: window,
      configureSDKs: self.configureSDKs
    )
  }
  
  static func configureSDKs() {
    #if DEBUG
    Gedatsu.open()
    #endif
  }
}
