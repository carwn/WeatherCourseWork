// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
// let dailyForecast = try? newJSONDecoder().decode(DailyForecast.self, from: jsonData)

import Foundation

struct DailyForecast: Codable {
    let headline: Headline
    let dailyForecasts: [DailyForecastElement]

    enum CodingKeys: String, CodingKey {
        case headline = "Headline"
        case dailyForecasts = "DailyForecasts"
    }
}
