//
//  WeatherSourceError.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 11.07.2022.
//

import Foundation

enum WeatherSourceError: LocalizedError {
    case cantCreateURL
    case noDataInResponce
    case other(Error)
    
    var errorDescription: String? {
        switch self {
        case .cantCreateURL:
            return "Can't create URL"
        case .noDataInResponce:
            return "No data in responce"
        case .other(let error):
            return error.localizedDescription
        }
    }
}
