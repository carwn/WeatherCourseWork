//
//  LSForecast+type.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 17.08.2022.
//

import Foundation

extension LSForecast {
    enum ForecastType: String {
        case daily, horly, currentConditions
    }
    
    var forecastType: ForecastType? {
        get {
            if let type = type {
                return ForecastType(rawValue: type)
            } else {
                return nil
            }
        }
        set {
            type = newValue?.rawValue
        }
    }
}
