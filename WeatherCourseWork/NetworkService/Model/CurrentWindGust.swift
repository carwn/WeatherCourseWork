// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
// let currentWindGust = try? newJSONDecoder().decode(CurrentWindGust.self, from: jsonData)

import Foundation

struct CurrentWindGust: Codable {
    let speed: MetricImperialValue

    enum CodingKeys: String, CodingKey {
        case speed = "Speed"
    }
}
