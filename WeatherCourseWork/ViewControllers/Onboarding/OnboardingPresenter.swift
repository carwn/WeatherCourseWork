//
//  OnboardingPresenter.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 04.08.2022.
//

import Foundation

class OnboardingPresenter {
    private let view: OnboardingViewController
    private let coordinator: ApplicationCoordinator
    private let locationManager: LocationManager
    
    init(view: OnboardingViewController, coordinator: ApplicationCoordinator, locationManager: LocationManager) {
        self.view = view
        self.coordinator = coordinator
        self.locationManager = locationManager
    }
    
    func useLocationButtonPressed() {
        view.startCoordinateSearchWaitingUI()
        locationManager.getCurrentLocation { [weak self] result in
            guard let self = self else { return }
            self.view.stopCoordinateSearchWaitingUI()
            switch result {
            case .success(let location):
                SettingsManager.shared.needOnboarding = false
                self.coordinator.dismissOnboard(setLocation: location)
            case .failure(let error):
                self.view.showError(error)
            }
        }
    }
    
    func dontUseLocationButtonPressed() {
        SettingsManager.shared.needOnboarding = false
        coordinator.dismissOnboard(setLocation: nil)
    }
}
