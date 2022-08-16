//
//  LSLocation+location.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 16.08.2022.
//

import Foundation

extension LSLocation {
    var location: Location? {
        guard
            let key = key,
            let localizedName = localizedName,
            let country = country?.country
        else {
            return nil
        }
        return Location(key: key, localizedName: localizedName, country: country)
    }
}
