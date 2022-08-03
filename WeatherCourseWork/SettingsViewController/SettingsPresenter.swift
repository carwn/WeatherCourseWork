//
//  SettingsPresenter.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 02.08.2022.
//

import Foundation

class SettingsPresenter {
    
    private let coordinator: ApplicationCoordinator
    private weak var view: SettingsViewController?
    
    init(view: SettingsViewController, coordinator: ApplicationCoordinator) {
        self.coordinator = coordinator
        self.view = view
    }
    
    func viewDidLoad() {
        guard let view = view else {
            return
        }
        view.addOption(SettingsManager.shared.temperature)
        view.addOption(SettingsManager.shared.windSpeed)
        view.addOption(SettingsManager.shared.time)
        view.addOption(SettingsManager.shared.notifications)
    }
    
    func setSettingsButtonPressed() {
        coordinator.dismissSettings()
    }
}
