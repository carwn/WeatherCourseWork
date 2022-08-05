//
//  LocationManagerError.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 05.08.2022.
//

import Foundation

enum LocationManagerError: LocalizedError {
    case cantGetLocation
    case other(Error)
    case cantGetTitleFromCoordinate
    
    var errorDescription: String? {
        switch self {
        case .cantGetLocation:
            return "Не удалось получить координаты"
        case .other(let error):
            return error.localizedDescription
        case .cantGetTitleFromCoordinate:
            return "Не удалось получить название из координаты"
        }
    }
}
