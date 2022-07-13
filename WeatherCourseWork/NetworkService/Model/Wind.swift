// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
// let wind = try? newJSONDecoder().decode(Wind.self, from: jsonData)

import Foundation

struct Wind: Codable {
    let speed: Value
    let direction: Direction

    enum CodingKeys: String, CodingKey {
        case speed = "Speed"
        case direction = "Direction"
    }
}
