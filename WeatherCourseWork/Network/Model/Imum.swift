// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
// let imum = try? newJSONDecoder().decode(Imum.self, from: jsonData)

import Foundation

struct Imum: Codable {
    let value: Double
    let unit: Unit
    let unitType: Int

    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
        case unitType = "UnitType"
    }
}
