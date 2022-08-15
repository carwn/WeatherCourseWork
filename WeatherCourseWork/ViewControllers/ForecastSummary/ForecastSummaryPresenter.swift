//
//  ForecastSummaryController.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 14.07.2022.
//

import UIKit

class ForecastSummaryPresenter {
    
    private let networkService: NetworkService
    private let coordinator: ApplicationCoordinator
    private weak var view: ForecastSummaryViewController?
    
    init(networkService: NetworkService, coordinator: ApplicationCoordinator, view: ForecastSummaryViewController) {
        self.networkService = networkService
        self.coordinator = coordinator
        self.view = view
    }
    
    var location: Location? {
        didSet {
            requestForecasts()
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
    
    func reloadForecasts() {
        requestForecasts()
    }
    
    private func requestForecasts(daily: Bool = false, hourly: Bool = false, current: Bool = true) {
        guard let location = location else {
            dailyForecast = nil
            horlyForecast = nil
            currentConditions = nil
            return
        }
        
        coordinator.startLoadingIndication()
        let group = DispatchGroup()
        
        if daily {
            group.enter()
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                guard let self = self else { return }
                self.networkService.dailyForecast(location: location, queue: .main) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let weather):
                        self.dailyForecast = weather
                    case .failure(let error):
                        self.dailyForecast = nil
                        self.view?.showError(error)
                        print(error)
                    }
                    group.leave()
                }
            }
        }
        
        if hourly {
            group.enter()
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                guard let self = self else { return }
                self.networkService.hourlyForecast(location: location, queue: .main) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let weather):
                        self.horlyForecast = weather
                    case .failure(let error):
                        self.horlyForecast = nil
                        self.view?.showError(error)
                        print(error)
                    }
                    group.leave()
                }
            }
        }
        
        if current {
            group.enter()
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                guard let self = self else { return }
                self.networkService.currentCondition(location: location, queue: .main) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let weather):
                        self.currentConditions = weather
                    case .failure(let error):
                        self.currentConditions = nil
                        self.view?.showError(error)
                        print(error)
                    }
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.coordinator.stopLoadingIndication()
        }
    }
}
