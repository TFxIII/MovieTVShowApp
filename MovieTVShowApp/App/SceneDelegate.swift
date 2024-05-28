//
//  SceneDelegate.swift
//  MovieTVShowApp
//
//  Created by Trynus Fedir on 08.04.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var coordinator: TabCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
        
        coordinator = TabCoordinator(navigationController)
        coordinator?.start()
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
    }
}
