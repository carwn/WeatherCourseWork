//
//  WeatherSource.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 11.07.2022.
//

import Foundation

class WeatherSource {
    
    private let apiKey = "UbwHM9iNznfqNhFQAolGGvG9ubUCtxDV"
    
    func dailyForecast(location: Location,
                       queue: DispatchQueue = .main,
                       completion: @escaping (Result<DailyForecast, WeatherSourceError>) -> Void) {
        forecast(type: .daily,
                 location: location,
                 queue: queue,
                 completion: completion)
    }
    
    func hourlyForecast(location: Location,
                        queue: DispatchQueue = .main,
                        completion: @escaping (Result<[HourlyForecastElement], WeatherSourceError>) -> Void) {
        forecast(type: .hourly,
                 location: location,
                 queue: queue,
                 completion: completion)
    }
    
    func currentCondition(location: Location,
                          queue: DispatchQueue = .main,
                          completion: @escaping (Result<[CurrentCondition], WeatherSourceError>) -> Void) {
        forecast(type: .current,
                 location: location,
                 queue: queue,
                 completion: completion)
    }
    
    private func forecast<T: Decodable>(type: ForecastType,
                                        location: Location,
                                        queue: DispatchQueue,
                                        completion: @escaping (Result<T, WeatherSourceError>) -> Void) {
        guard let url = weatherURL(accuWeatherID: location.accuWeatherID, type: type) else {
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
    
    private func weatherURL(accuWeatherID: AccuWeatherID, type: ForecastType) -> URL? {
        let queryItems = [URLQueryItem(name: "apikey", value: apiKey),
                          URLQueryItem(name: "language", value: "ru-ru"),
                          URLQueryItem(name: "details", value: "true"),
                          URLQueryItem(name: "metric", value: "true")]
        var urlComponents = URLComponents(string: "\(type.baseURL)\(accuWeatherID)")
        urlComponents?.queryItems = queryItems
        return urlComponents?.url
    }
}

extension WeatherSource {
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
