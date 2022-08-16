//
//  DependencyFactory.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 02.08.2022.
//

import UIKit

class DependencyFactory {
    
    private let networkService: NetworkService
    private let forecastSource: ForecastSource
    private lazy var locationManager = LocationManager(networkService: networkService)
    
    init(localStore: LocalStore) {
        let networkService = NetworkService()
        self.networkService = networkService
        self.forecastSource = ForecastSource(networkService: networkService, localStore: localStore)
    }
    
    func makeForecastSummaryViewController(coordinator: ApplicationCoordinator, location: Location?) -> ForecastSummaryViewController {
        let storyBoard = UIStoryboard(name: "ForecastSummary", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ForecastSummaryViewController") as! ForecastSummaryViewController
        let presenter = ForecastSummaryPresenter(forecastSource: forecastSource, coordinator: coordinator, view: vc)
        vc.presenter = presenter
        presenter.location = location
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
        let presenter = OnboardingPresenter(view: vc, coordinator: coordinator, locationManager: locationManager)
        vc.presenter = presenter
        return vc
    }
    
    func makeForecastsPageViewController(coordinator: ApplicationCoordinator, locations: [Location]) -> ForecastsPagesViewController {
        let vc = ForecastsPagesViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        vc.view.backgroundColor = .white
        let presenter = ForecastsPagesPresenter(networkService: networkService, coordinator: coordinator, view: vc, factory: self, locations: locations)
        vc.presenter = presenter
        return vc
    }
}
