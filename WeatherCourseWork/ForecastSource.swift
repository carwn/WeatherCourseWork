//
//  ForecastSource.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 16.08.2022.
//

import Foundation

class ForecastSource {
    
    private let networkService: NetworkService
    private let localStore: LocalStore
    
    init(networkService: NetworkService, localStore: LocalStore) {
        self.networkService = networkService
        self.localStore = localStore
    }
    
    func dailyForecast(location: Location, forceUpdateFromNetwork: Bool, completion: @escaping (Result<(DailyForecast, Date), Error>) -> Void) {
        func requestNetwork() {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                guard let self = self else { return }
                self.networkService.dailyForecast(location: location, queue: .main) { result in
                    switch result {
                    case .success(let weather):
                        self.localStore.saveForecast(weather, location: location)
                        completion(.success((weather, Date())))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        }
        if forceUpdateFromNetwork {
            requestNetwork()
        } else {
            self.localStore.dailyForecast(location: location, queue: .main) { result in
                switch result {
                case .success(let forecast):
                    if let forecast = forecast {
                        completion(.success(forecast))
                    } else {
                        requestNetwork()
                    }
                case .failure(let error):
                    completion(.failure(error))
                    requestNetwork()
                }
            }
        }
    }
    
    func horlyForecasts(location: Location, forceUpdateFromNetwork: Bool, completion: @escaping (Result<([HourlyForecastElement], Date), Error>) -> Void) {
        func requestNetwork() {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                guard let self = self else { return }
                self.networkService.hourlyForecast(location: location, queue: .main) { result in
                    switch result {
                    case .success(let weather):
                        self.localStore.saveForecast(weather, location: location)
                        completion(.success((weather, Date())))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        }
        if forceUpdateFromNetwork {
            requestNetwork()
        } else {
            self.localStore.hourlyForecasts(location: location, queue: .main) { result in
                switch result {
                case .success(let forecast):
                    if let forecast = forecast {
                        completion(.success(forecast))
                    } else {
                        requestNetwork()
                    }
                case .failure(let error):
                    completion(.failure(error))
                    requestNetwork()
                }
            }
        }
    }
    
    
    func currentConditions(location: Location, forceUpdateFromNetwork: Bool, completion: @escaping (Result<([CurrentCondition], Date), Error>) -> Void) {
        func requestNetwork() {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                guard let self = self else { return }
                self.networkService.currentCondition(location: location, queue: .main) { result in
                    switch result {
                    case .success(let weather):
                        self.localStore.saveForecast(weather, location: location)
                        completion(.success((weather, Date())))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        }
        if forceUpdateFromNetwork {
            requestNetwork()
        } else {
            self.localStore.currentConditions(location: location, queue: .main) { result in
                switch result {
                case .success(let forecast):
                    if let forecast = forecast {
                        completion(.success(forecast))
                    } else {
                        requestNetwork()
                    }
                case .failure(let error):
                    completion(.failure(error))
                    requestNetwork()
                }
            }
        }
    }
    
}
