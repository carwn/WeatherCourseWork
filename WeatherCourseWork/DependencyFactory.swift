//
//  DependencyFactory.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 02.08.2022.
//

import UIKit

class DependencyFactory {
    
    private let networkService = NetworkService()
    
    func makeForecastSummaryViewController(coordinator: ApplicationCoordinator) -> ForecastSummaryViewController {
        let storyBoard = UIStoryboard(name: "ForecastSummary", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ForecastSummaryViewController") as! ForecastSummaryViewController
        let presenter = ForecastSummaryPresenter(networkService: networkService, coordinator: coordinator, view: vc)
        vc.presenter = presenter
        return vc
    }
    
    func makeSettingsViewController(coordinator: ApplicationCoordinator) -> SettingsViewController {
        let vc = SettingsViewController()
        let presenter = SettingsPresenter(view: vc, coordinator: coordinator)
        vc.presenter = presenter
        return vc
    }
    
    func makeOnboardingViewController(coordinator: ApplicationCoordinator) -> OnboardingViewController {
        let vc = OnboardingViewController(nibName: "OnboardingViewController", bundle: nil)
        let presenter = OnboardingPresenter(view: vc, coordinator: coordinator)
        vc.presenter = presenter
        return vc
    }
}
