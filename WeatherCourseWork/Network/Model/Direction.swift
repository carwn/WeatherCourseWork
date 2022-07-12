// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
// let direction = try? newJSONDecoder().decode(Direction.self, from: jsonData)

import Foundation

struct Direction: Codable {
    let degrees: Int
    let localized, english: String

    enum CodingKeys: String, CodingKey {
        case degrees = "Degrees"
        case localized = "Localized"
        case english = "English"
    }
}
