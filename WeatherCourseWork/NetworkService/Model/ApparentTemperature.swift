// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
// let apparentTemperature = try? newJSONDecoder().decode(ApparentTemperature.self, from: jsonData)

import Foundation

struct ApparentTemperature: Codable {
    let metric, imperial: Value

    enum CodingKeys: String, CodingKey {
        case metric = "Metric"
        case imperial = "Imperial"
    }
}
