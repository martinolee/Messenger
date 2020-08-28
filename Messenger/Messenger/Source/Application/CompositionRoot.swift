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
  static func configureSDKs() {
    #if DEBUG
    Gedatsu.open()
    #endif
  }
}
