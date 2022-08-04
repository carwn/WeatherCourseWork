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
    
    init(view: OnboardingViewController, coordinator: ApplicationCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func useLocationButtonPressed() {
        coordinator.dismissOnboard()
    }
    
    func dontUseLocationButtonPressed() {
        coordinator.dismissOnboard()
    }
}
