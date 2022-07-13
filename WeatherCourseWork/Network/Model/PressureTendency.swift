// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
// let pressureTendency = try? newJSONDecoder().decode(PressureTendency.self, from: jsonData)

import Foundation

struct PressureTendency: Codable {
    let localizedText, code: String

    enum CodingKeys: String, CodingKey {
        case localizedText = "LocalizedText"
        case code = "Code"
    }
}
