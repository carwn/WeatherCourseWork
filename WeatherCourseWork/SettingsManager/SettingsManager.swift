//
//  SettingsManager.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 02.08.2022.
//

import Foundation

class SettingsManager {
    static let shared = SettingsManager()
    private init() {}
    
    var temperature: Temperature {
        get {
            if let rawValue = getValue(forKey: Temperature.key), let value = Temperature(rawValue: rawValue) {
                return value
            } else {
                return .celsius
            }
        }
        set {
            save(value: newValue.rawValue, forKey: Temperature.key)
        }
    }
    
    var windSpeed: WindSpeed {
        get {
            if let rawValue = getValue(forKey: WindSpeed.key), let value = WindSpeed(rawValue: rawValue) {
                return value
            } else {
                return .kilometers
            }
        }
        set {
            save(value: newValue.rawValue, forKey: WindSpeed.key)
        }
    }
    
    var time: Time {
        get {
            if let rawValue = getValue(forKey: Time.key), let value = Time(rawValue: rawValue) {
                return value
            } else {
                return .twentyFour
            }
        }
        set {
            save(value: newValue.rawValue, forKey: Time.key)
        }
    }
    
    var notifications: Notifications {
        get {
            if let rawValue = getValue(forKey: Notifications.key), let value = Notifications(rawValue: rawValue) {
                return value
            } else {
                return .on
            }
        }
        set {
            save(value: newValue.rawValue, forKey: Notifications.key)
        }
    }
    
    private let userDefaults = UserDefaults.standard
    
    private func save(value: Int, forKey key: String) {
        userDefaults.set(value, forKey: key)
    }
    
    private func getValue(forKey key: String) -> Int? {
        userDefaults.value(forKey: key) as? Int
    }
}


