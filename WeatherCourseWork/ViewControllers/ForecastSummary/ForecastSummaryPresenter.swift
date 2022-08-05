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
            view?.locationDidUpdate()
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
    
    func searchLocation(searchString: String?) {
        guard
            let searchString = searchString,
            !searchString.isEmpty
        else {
            view?.showError("Не введена строка для поиска")
            return
        }
        view?.startLoadingIndication()
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            self.networkService.locations(searchString: searchString, queue: .main) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let locations):
                    if !locations.isEmpty {
                        self.location = locations.first
                    } else {
                        self.view?.showError("Не удалось найти город с таким названием")
                    }
                case .failure(let error):
                    self.view?.showError(error)
                    print(error)
                }
                self.view?.stopLoadingIndication()
            }
        }
    }
    
    func openAppSettings() {
        coordinator.openSettings()
    }
    
    private func requestForecasts(daily: Bool = false, hourly: Bool = false, current: Bool = true) {
        guard let location = location else {
            dailyForecast = nil
            horlyForecast = nil
            currentConditions = nil
            return
        }
        
        view?.startLoadingIndication()
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
            self?.view?.stopLoadingIndication()
        }
    }
}
