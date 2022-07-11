// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
// let dailyForecastElement = try? newJSONDecoder().decode(DailyForecastElement.self, from: jsonData)

import Foundation

struct DailyForecastElement: Codable {
    let date: Date
    let epochDate: Int
    let temperature: Temperature
    let day, night: Forecast
    let sources: [String]
    let mobileLink, link: String

    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case epochDate = "EpochDate"
        case temperature = "Temperature"
        case day = "Day"
        case night = "Night"
        case sources = "Sources"
        case mobileLink = "MobileLink"
        case link = "Link"
    }
}
