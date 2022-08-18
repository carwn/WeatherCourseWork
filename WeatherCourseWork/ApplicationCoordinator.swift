//
//  ApplicationCoordinator.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 14.07.2022.
//

import UIKit

final class ApplicationCoordinator {
    
    var navigationController: UINavigationController?
    
    private let factory: DependencyFactory
    private let localStore: LocalStore

    init() {
        let localStore = LocalStore()
        self.factory = DependencyFactory(localStore: localStore)
        self.localStore = localStore
        localStore.delegate = self
    }

    func start() {
        guard let navigationController = navigationController else { return }
        if SettingsManager.shared.needOnboarding {
            let vc = factory.makeOnboardingViewController(coordinator: self)
            navigationController.viewControllers = [vc]
        } else {
            openLocationsFromStore(animated: true)
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
            reloadCurrentPageForecastSummary()
        }
        dismissModal(vcType: SettingsViewController.self)
    }
    
    func dismissOnboard(setLocation location: Location?) {
        if let location = location {
            startLoadingIndication()
            localStore.addLocationAsFirst(location) { result in
                stopLoadingIndication()
                switch result {
                case .success():
                    break
                case .failure(let error):
                    showError(error)
                }
                openLocationsFromStore(animated: true)
            }
        } else {
            openLocationsFromStore(animated: true)
        }
    }
    
    func showForecastForNewLocation(_ location: Location) {
        localStore.addLocationAsLast(location) { result in
            switch result {
            case .success():
                if localStore.locationsCount == 1 {
                    openLocationsFromStore(animated: false)
                } else {
                    pagesPresenter?.addPage(location: location)
                }
            case .failure(let error):
                showError(error)
            }
        }
    }
    
    func startLoadingIndication() {
        pagesPresenter?.startLoadingIndication()
    }
    
    func stopLoadingIndication() {
        pagesPresenter?.stopLoadingIndication()
    }
    
    func showError(_ error: Error) {
        pageViewController?.showError(error)
    }
    
    func updateLastForecastUpdateDate(_ date: Date?) {
        pagesPresenter?.updateLastForecastUpdateDate(date)
    }
    
    private var pageViewController: ForecastsPagesViewController? {
        navigationController?.viewControllers.first as? ForecastsPagesViewController
    }
    
    private var pagesPresenter: ForecastsPagesPresenter? {
        pageViewController?.presenter
    }
    
    private func reloadCurrentPageForecastSummary() {
        pagesPresenter?.reloadForecasts(forceUpdateFromNetwork: true)
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
    
    private func openLocationsFromStore(animated: Bool) {
        localStore.locations { result in
            switch result {
            case .success(let locations):
                let vc = factory.makeForecastsPageViewController(coordinator: self, locations: locations)
                navigationController?.setViewControllers([vc], animated: animated)
            case .failure(let error):
                showError(error)
            }
        }
    }
}

extension ApplicationCoordinator: LocalStoreDelegate {
    func throwError(_ error: Error) {
        showError(error)
    }
}
