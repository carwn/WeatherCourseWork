// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
// let realFeelTemperature = try? newJSONDecoder().decode(RealFeelTemperature.self, from: jsonData)

import Foundation

struct Temperature: Codable {
    let minimum, maximum: Value

    enum CodingKeys: String, CodingKey {
        case minimum = "Minimum"
        case maximum = "Maximum"
    }
}
