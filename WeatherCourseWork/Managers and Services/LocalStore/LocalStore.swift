//
//  LocalStore.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 10.08.2022.
//

import Foundation

class LocalStore {
    
    weak var delegate: LocalStoreDelegate?
    
    private(set) var locations: [Location]
    
    init() {
        let country = Country(id: "7", localizedName: "Россия f", englishName: "Russia f")
        let mos = Location(key: "294021", localizedName: "Москва f", country: country)
        let tash = Location(key: "288383", localizedName: "Таштагол f", country: country)
        locations = [mos, tash]
    }
    
    func addLocationAsFirst(_ newLocation: Location) {
        locations.insert(newLocation, at: 0)
        delegate?.newLocationDidAddAsFirst()
    }
    
    func addLocationAsLast(_ newLocation: Location) {
        locations.append(newLocation)
        if locations.count == 1 {
            delegate?.newLocationDidAddAsFirst()
        } else {
            delegate?.newLocationDidAddAsLast()
        }
    }
}
