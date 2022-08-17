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
    
    func dailyForecast(location: Location, completion: @escaping (Result<(DailyForecast, Date), Error>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            func requestNetwork() {
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
    
    func horlyForecasts(location: Location, completion: @escaping (Result<([HourlyForecastElement], Date), Error>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            func requestNetwork() {
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
    
    func currentConditions(location: Location, completion: @escaping (Result<([CurrentCondition], Date), Error>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            func requestNetwork() {
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
