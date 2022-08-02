//
//  SettingsManagerOption.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 02.08.2022.
//

import Foundation

protocol SettingsManagerOption: CaseIterable {
    static var key: String { get }
    var title: String { get }
}

extension SettingsManager {
    
    enum Temperature: Int, SettingsManagerOption {
        case celsius, fahrenheit
        
        static var key: String {
            "temperature"
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
