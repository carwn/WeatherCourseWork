//
//  NetworkService.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 11.07.2022.
//

import Foundation

class NetworkService {
    
    private let apiKey = "UbwHM9iNznfqNhFQAolGGvG9ubUCtxDV"
    
    func dailyForecast(location: Location,
                       queue: DispatchQueue = .main,
                       completion: @escaping (Result<DailyForecast, NetworkServiceError>) -> Void) {
        requst(url: weatherURL(accuWeatherID: location.key, type: .daily), queue: queue, completion: completion)
    }
    
    func hourlyForecast(location: Location,
                        queue: DispatchQueue = .main,
                        completion: @escaping (Result<[HourlyForecastElement], NetworkServiceError>) -> Void) {
        requst(url: weatherURL(accuWeatherID: location.key, type: .hourly), queue: queue, completion: completion)
    }
    
    func currentCondition(location: Location,
                          queue: DispatchQueue = .main,
                          completion: @escaping (Result<[CurrentCondition], NetworkServiceError>) -> Void) {
        requst(url: weatherURL(accuWeatherID: location.key, type: .current), queue: queue, completion: completion)
    }
    
    func locations(searchString: String,
                          queue: DispatchQueue = .main,
                          completion: @escaping (Result<[Location], NetworkServiceError>) -> Void) {
        requst(url: locationsURL(searchString: searchString), queue: queue, completion: completion)
    }
    
    private func requst<T: Decodable>(url: URL?,
                                      queue: DispatchQueue,
                                      completion: @escaping (Result<T, NetworkServiceError>) -> Void) {
        guard let url = url else {
            queue.async {
                completion(.failure(.cantCreateURL))
            }
            return
        }
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let error = error {
                queue.async {
                    completion(.failure(.other(error)))
                }
                return
            }
            guard let data = data else {
                queue.async {
                    completion(.failure(.noDataInResponce))
                }
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let weather = try decoder.decode(T.self, from: data)
                queue.async {
                    completion(.success(weather))
                }
            } catch {
                queue.async {
                    completion(.failure(.other(error)))
                }
            }
        }.resume()
    }
    
    private func weatherURL(accuWeatherID: String, type: ForecastType) -> URL? {
        let queryItems = [URLQueryItem(name: "apikey", value: apiKey),
                          URLQueryItem(name: "language", value: "ru-ru"),
                          URLQueryItem(name: "details", value: "true"),
                          URLQueryItem(name: "metric", value: SettingsManager.shared.temperature.metric)]
        var urlComponents = URLComponents(string: "\(type.baseURL)\(accuWeatherID)")
        urlComponents?.queryItems = queryItems
        return urlComponents?.url
    }
    
    private func locationsURL(searchString: String) -> URL? {
        let queryItems = [URLQueryItem(name: "apikey", value: apiKey),
                          URLQueryItem(name: "q", value: searchString),
                          URLQueryItem(name: "language", value: "ru-ru"),
                          URLQueryItem(name: "details", value: "false")]
        var urlComponents = URLComponents(string: "http://dataservice.accuweather.com/locations/v1/cities/search")
        urlComponents?.queryItems = queryItems
        return urlComponents?.url
    }
}

private extension NetworkService {
    enum ForecastType {
        case daily, hourly, current
        
        var baseURL: String {
            switch self {
            case .daily:
                return "http://dataservice.accuweather.com/forecasts/v1/daily/5day/"
            case .hourly:
                return "http://dataservice.accuweather.com/forecasts/v1/hourly/12hour/"
            case .current:
                return "http://dataservice.accuweather.com/currentconditions/v1/"
            }
        }
    }
}

private extension SettingsManager.Temperature {
    var metric: String {
        switch self {
        case .celsius:
            return "true"
        case .fahrenheit:
            return "false"
        }
    }
}
