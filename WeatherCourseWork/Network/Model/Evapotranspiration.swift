// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
// let evapotranspiration = try? newJSONDecoder().decode(Evapotranspiration.self, from: jsonData)

import Foundation

struct Evapotranspiration: Codable {
    let value: Double
    let unit: Unit
    let unitType: Int
    let phrase: Phrase?

    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
        case unitType = "UnitType"
        case phrase = "Phrase"
    }
}
