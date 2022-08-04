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
    private var needReloadForecastSummary = false
    
    init(view: SettingsViewController, coordinator: ApplicationCoordinator) {
        self.coordinator = coordinator
        self.view = view
    }
    
    func viewDidLoad() {
        addOptionsToView()
    }
    
    func setSettingsButtonPressed() {
        coordinator.dismissSettings(needReloadForecastSummary: needReloadForecastSummary)
    }
    
    private func addOptionsToView() {
        guard let view = view else {
            return
        }
        view.addOption(settingsManagerOption: SettingsManager.shared.temperature) { [weak self] newIndex in
            if let temperature = SettingsManager.Temperature(rawValue: newIndex), temperature != SettingsManager.shared.temperature {
                SettingsManager.shared.temperature = temperature
                self?.needReloadForecastSummary = true
            }
        }
        view.addOption(settingsManagerOption: SettingsManager.shared.windSpeed) { [weak self] newIndex in
            if let windSpeed = SettingsManager.WindSpeed(rawValue: newIndex), windSpeed != SettingsManager.shared.windSpeed {
                SettingsManager.shared.windSpeed = windSpeed
                self?.needReloadForecastSummary = true
            }
        }
        view.addOption(settingsManagerOption: SettingsManager.shared.time) { [weak self] newIndex in
            if let time = SettingsManager.Time(rawValue: newIndex), time != SettingsManager.shared.time {
                SettingsManager.shared.time = time
                self?.needReloadForecastSummary = true
            }
        }
        view.addOption(settingsManagerOption: SettingsManager.shared.notifications) { [weak self] newIndex in
            if let notifications = SettingsManager.Notifications(rawValue: newIndex), notifications != SettingsManager.shared.notifications {
                SettingsManager.shared.notifications = notifications
                self?.needReloadForecastSummary = true
            }
        }
    }
}
