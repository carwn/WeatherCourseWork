// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
// let currentWind = try? newJSONDecoder().decode(CurrentWind.self, from: jsonData)

import Foundation

struct CurrentWind: Codable {
    let speed: MetricImperialValue
    let direction: Direction

    enum CodingKeys: String, CodingKey {
        case speed = "Speed"
        case direction = "Direction"
    }
}
