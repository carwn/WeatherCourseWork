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
        guard let url = dailyWeatherURL(accuWeatherID: location.accuWeatherID) else {
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
                let weather = try decoder.decode(DailyForecast.self, from: data)
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
    
    private func dailyWeatherURL(accuWeatherID: AccuWeatherID) -> URL? {
        let queryItems = [URLQueryItem(name: "apikey", value: apiKey),
                          URLQueryItem(name: "language", value: "ru-ru"),
                          URLQueryItem(name: "details", value: "true"),
                          URLQueryItem(name: "metric", value: "true")]
        var urlComponents = URLComponents(string: "http://dataservice.accuweather.com/forecasts/v1/daily/5day/\(accuWeatherID)")
        urlComponents?.queryItems = queryItems
        return urlComponents?.url
    }
}
