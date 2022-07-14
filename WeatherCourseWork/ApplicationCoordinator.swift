//
//  ApplicationCoordinator.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 14.07.2022.
//

import UIKit

final class ApplicationCoordinator {

    private let window: UIWindow
    private let mainNavigationController: UINavigationController

    private let networkService: NetworkService
    
    init(scene: UIWindowScene) {
        let networkService = NetworkService()
        let window = UIWindow(windowScene: scene)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainNavigationController = storyboard.instantiateViewController(withIdentifier: "mainNavigationController") as! UINavigationController
        for viewController in mainNavigationController.viewControllers {
            if let forecastSummaryViewController = viewController as? ForecastSummaryViewController {
                forecastSummaryViewController.networkService = networkService
            }
        }
        window.rootViewController = mainNavigationController
        self.window = window
        self.mainNavigationController = mainNavigationController
        self.networkService = networkService
    }

    func start() {
        window.makeKeyAndVisible()
    }
}
