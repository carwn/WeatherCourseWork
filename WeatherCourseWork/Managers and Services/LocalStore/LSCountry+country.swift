//
//  LSCountry+country.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 16.08.2022.
//

import Foundation

extension LSCountry {
    var country: Country? {
        guard
            let id = id,
            let localizedName = localizedName,
            let englishName = englishName
        else {
            return nil
        }
        return Country(id: id, localizedName: localizedName, englishName: englishName)
    }
}
