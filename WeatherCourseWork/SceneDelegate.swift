//
//  SceneDelegate.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 10.07.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    private var appCoordinator = ApplicationCoordinator()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let rootNavigationController = UINavigationController()
        appCoordinator.navigationController = rootNavigationController
        appCoordinator.start()
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
    }
}
