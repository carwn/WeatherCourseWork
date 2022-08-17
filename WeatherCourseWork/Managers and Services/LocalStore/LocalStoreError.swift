//
//  LocalStoreError.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 16.08.2022.
//

import Foundation

enum LocalStoreError: Error {
    case cantParseStoredLocations
    case moreOneCountryWithID
    case moreOneLocationWithID
    case other(Error)
}
