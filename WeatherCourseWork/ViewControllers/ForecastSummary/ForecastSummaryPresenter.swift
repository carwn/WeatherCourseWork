//
//  ForecastSummaryController.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 14.07.2022.
//

import UIKit

class ForecastSummaryPresenter {
    
    private let forecastSource: ForecastSource
    private let coordinator: ApplicationCoordinator
    private weak var view: ForecastSummaryViewController?
    
    init(forecastSource: ForecastSource, coordinator: ApplicationCoordinator, view: ForecastSummaryViewController) {
        self.forecastSource = forecastSource
        self.coordinator = coordinator
        self.view = view
    }
    
    var location: Location? {
        didSet {
            requestForecasts(forceUpdateFromNetwork: false)
        }
    }
    
    private(set) var dailyForecast: DailyForecast? {
        didSet {
            view?.dailyForecastDidUpdate()
        }
    }
    private(set) var horlyForecast: [HourlyForecastElement]? {
        didSet {
            view?.horlyForecastDidUpdate()
        }
    }
    private(set) var currentConditions: [CurrentCondition]? {
        didSet {
            view?.currentConditionsDidUpdate()
        }
    }
    
    func reloadForecasts(forceUpdateFromNetwork: Bool) {
        requestForecasts(forceUpdateFromNetwork: forceUpdateFromNetwork)
    }
    
    private func requestForecasts(daily: Bool = true, hourly: Bool = true, current: Bool = true, forceUpdateFromNetwork: Bool) {
        guard let location = location else {
            dailyForecast = nil
            horlyForecast = nil
            currentConditions = nil
            return
        }
        
        coordinator.startLoadingIndication()
        let group = DispatchGroup()
        var updateDailyForecastDate: Date?
        var updateHourlyForecastDate: Date?
        var updateCurrentForecastDate: Date?
        
        if daily {
            group.enter()
            forecastSource.dailyForecast(location: location, forceUpdateFromNetwork: forceUpdateFromNetwork) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let weather):
                    self.dailyForecast = weather.0
                    updateDailyForecastDate = weather.1
                case .failure(let error):
                    self.coordinator.showError(error)
                }
                group.leave()
            }
        }
        
        if hourly {
            group.enter()
            forecastSource.horlyForecasts(location: location, forceUpdateFromNetwork: forceUpdateFromNetwork) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let weather):
                    self.horlyForecast = weather.0
                    updateHourlyForecastDate = weather.1
                case .failure(let error):
                    self.coordinator.showError(error)
                }
                group.leave()
            }
        }
        
        if current {
            group.enter()
            forecastSource.currentConditions(location: location, forceUpdateFromNetwork: forceUpdateFromNetwork) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let weather):
                    self.currentConditions = weather.0
                    updateCurrentForecastDate = weather.1
                case .failure(let error):
                    self.coordinator.showError(error)
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.coordinator.stopLoadingIndication()
            let lastUpdateDate = [updateDailyForecastDate, updateHourlyForecastDate, updateCurrentForecastDate].compactMap { $0 }.sorted().first
            if let lastUpdateDate = lastUpdateDate {
                self.coordinator.updateLastForecastUpdateDate(lastUpdateDate)
            }
        }
    }
}
