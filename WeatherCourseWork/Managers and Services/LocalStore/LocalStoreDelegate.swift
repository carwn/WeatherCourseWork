//
//  LocalStoreDelegate.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 10.08.2022.
//

import Foundation

protocol LocalStoreDelegate: AnyObject {
    func throwError(_: Error)
}
