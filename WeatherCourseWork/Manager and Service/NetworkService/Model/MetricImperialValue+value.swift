//
//  MetricImperialValue+value.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 03.08.2022.
//

import Foundation

extension MetricImperialValue {
    var temperatureValue: Value {
        switch SettingsManager.shared.temperature {
        case .celsius:
            return metric
        case .fahrenheit:
            return imperial
        }
    }
    
    var windValue: Value {
        switch SettingsManager.shared.windSpeed {
        case .kilometers:
            return metric
        case .miles:
            return imperial
        }
    }
}
