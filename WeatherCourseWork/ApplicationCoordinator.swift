//
//  ApplicationCoordinator.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 14.07.2022.
//

import UIKit

final class ApplicationCoordinator {
    
    var navigationController: UINavigationController?
    
    private let factory = DependencyFactory()

    func start() {
        guard let navigationController = navigationController else { return }
        if SettingsManager.shared.needOnboarding {
            let vc = factory.makeOnboardingViewController(coordinator: self)
            navigationController.viewControllers = [vc]
        } else {
            let vc = factory.makeForecastSummaryViewController(coordinator: self)
            navigationController.viewControllers = [vc]
        }
    }
    
    func openSettings() {
        guard let navigationController = navigationController else { return }
        let vc = factory.makeSettingsViewController(coordinator: self)
        vc.modalPresentationStyle = .fullScreen
        navigationController.present(vc, animated: true)
    }
    
    func dismissSettings(needReloadForecastSummary: Bool) {
        if needReloadForecastSummary {
            reloadForecastSummary()
        }
        dismissModal(vcType: SettingsViewController.self)
    }
    
    func dismissOnboard() {
        let vc = factory.makeForecastSummaryViewController(coordinator: self)
        navigationController?.setViewControllers([vc], animated: true)
    }
    
    private func dismissModal<T: UIViewController>(vcType: T.Type) {
        guard
            let navigationController = navigationController,
            navigationController.visibleViewController is T
        else {
            return
        }
        navigationController.visibleViewController?.dismiss(animated: true)
    }
    
    private var forecastSummaryPresenter: ForecastSummaryPresenter? {
        guard let navigationController = navigationController else {
            return nil
        }
        for vc in navigationController.viewControllers {
            if let vc = vc as? ForecastSummaryViewController {
                return vc.presenter
            }
        }
        return nil
    }
    
    private func reloadForecastSummary() {
        forecastSummaryPresenter?.reloadForecasts()
    }
}
