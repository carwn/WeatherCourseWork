//
//  Array+indexOf.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 08.08.2022.
//

import Foundation

extension Array where Element: AnyObject {
    func indexOf(_ testElement: Element) -> Index? {
        for (index, element) in enumerated() {
            if element === testElement {
                return index
            }
        }
        return nil
    }
}
