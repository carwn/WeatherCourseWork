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
        addOptionsToView()
    }
    
    func setSettingsButtonPressed() {
        coordinator.dismissSettings()
    }
    
    private func addOptionsToView() {
        guard let view = view else {
            return
        }
        view.addOption(settingsManagerOption: SettingsManager.shared.temperature) { newIndex in
            if let temperature = SettingsManager.Temperature(rawValue: newIndex) {
                SettingsManager.shared.temperature = temperature
            }
        }
        view.addOption(settingsManagerOption: SettingsManager.shared.windSpeed) { newIndex in
            if let windSpeed = SettingsManager.WindSpeed(rawValue: newIndex) {
                SettingsManager.shared.windSpeed = windSpeed
            }
        }
        view.addOption(settingsManagerOption: SettingsManager.shared.time) { newIndex in
            if let time = SettingsManager.Time(rawValue: newIndex) {
                SettingsManager.shared.time = time
            }
        }
        view.addOption(settingsManagerOption: SettingsManager.shared.notifications) { newIndex in
            if let notifications = SettingsManager.Notifications(rawValue: newIndex) {
                SettingsManager.shared.notifications = notifications
            }
        }
    }
}
