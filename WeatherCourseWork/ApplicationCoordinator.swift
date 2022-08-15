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
        self.factory = DependencyFactory()
        self.localStore = LocalStore()
        localStore.delegate = self
    }

    func start() {
        guard let navigationController = navigationController else { return }
        if SettingsManager.shared.needOnboarding {
            let vc = factory.makeOnboardingViewController(coordinator: self)
            navigationController.viewControllers = [vc]
        } else {
            setPageVC(locations: [])
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
            localStore.addLocationAsFirst(location)
        } else {
            setPageVC(locations: localStore.locations)
        }
    }
    
    func showForecastForNewLocation(_ location: Location) {
        localStore.addLocationAsLast(location)
    }
    
    func startLoadingIndication() {
        pagesPresenter?.startLoadingIndication()
    }
    
    func stopLoadingIndication() {
        pagesPresenter?.stopLoadingIndication()
    }
    
    private var pageViewController: ForecastsPagesViewController? {
        navigationController?.viewControllers.first as? ForecastsPagesViewController
    }
    
    private var pagesPresenter: ForecastsPagesPresenter? {
        pageViewController?.presenter
    }
    
    private func setPageVC(locations: [Location]) {
        let vc = factory.makeForecastsPageViewController(coordinator: self, locations: locations)
        navigationController?.setViewControllers([vc], animated: true)
    }
    
    private func reloadCurrentPageForecastSummary() {
        pagesPresenter?.reloadForecasts()
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
}

extension ApplicationCoordinator: LocalStoreDelegate {
    func newLocationDidAddAsFirst() {
        setPageVC(locations: localStore.locations)
    }
    
    func newLocationDidAddAsLast() {
        pagesPresenter?.addPage(location: localStore.locations.last!)
    }
}
