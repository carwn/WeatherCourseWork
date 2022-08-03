//
//  Date+timeString.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 03.08.2022.
//

import Foundation

extension Date {
    var timeString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = timeFormat()
        dateFormatter.timeZone = Calendar.current.dateComponents([.timeZone], from: self).timeZone
        return dateFormatter.string(from: self)
    }
    
    private func timeFormat() -> String {
        switch SettingsManager.shared.time {
        case .twelve:
            return "hh:mm"
        case .twentyFour:
            return "HH:mm"
        }
    }
}
