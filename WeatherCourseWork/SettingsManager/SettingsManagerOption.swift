//
//  SettingsManagerOption.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 02.08.2022.
//

import Foundation

protocol SettingsManagerOption: Equatable, CaseIterable {
    static var key: String { get }
    static var title: String { get }
    var title: String { get }
}

extension SettingsManager {
    
    enum Temperature: Int, SettingsManagerOption {
        case celsius, fahrenheit
        
        static var key: String {
            "temperature"
        }
        
        static var title: String {
            "Температура"
        }
        
        var title: String {
            switch self {
            case .celsius:
                return "C"
            case .fahrenheit:
                return "F"
            }
        }
    }
    
    enum WindSpeed: Int, SettingsManagerOption {
        case miles, kilometers
        
        static var key: String {
            "windSpeed"
        }
        
        static var title: String {
            "Скорость ветра"
        }
        
        var title: String {
            switch self {
            case .miles:
                return "Mi"
            case .kilometers:
                return "Km"
            }
        }
    }
    
    enum Time: Int, SettingsManagerOption {
        case twelve, twentyFour
        
        static var key: String {
            "time"
        }
        
        static var title: String {
            "Формат времени"
        }
        
        var title: String {
            switch self {
            case .twelve:
                return "12"
            case .twentyFour:
                return "24"
            }
        }
    }
    
    enum Notifications: Int, SettingsManagerOption {
        case on, off
        
        static var key: String {
            "notifications"
        }
        
        static var title: String {
            "Уведомления"
        }
        
        var title: String {
            switch self {
            case .on:
                return "On"
            case .off:
                return "Off"
            }
        }
    }
}
