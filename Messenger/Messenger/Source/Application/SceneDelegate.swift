//
//  SceneDelegate.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/08/29.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit


class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var dependency: AppDependency!
  
  var window: UIWindow?
  
  
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    dependency = dependency ?? CompositionRoot.resolve(for: windowScene)
    dependency.configureSDKs()
    
    window = dependency.window
  }
  
}
