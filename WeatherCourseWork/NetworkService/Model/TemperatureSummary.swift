// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
// let temperatureSummary = try? newJSONDecoder().decode(TemperatureSummary.self, from: jsonData)

import Foundation

struct TemperatureSummary: Codable {
    let past6HourRange, past12HourRange, past24HourRange: PastHourRange

    enum CodingKeys: String, CodingKey {
        case past6HourRange = "Past6HourRange"
        case past12HourRange = "Past12HourRange"
        case past24HourRange = "Past24HourRange"
    }
}
