// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
// let value = try? newJSONDecoder().decode(Value.self, from: jsonData)

import Foundation

struct Value: Codable {
    let value: Double
    let unit: String
    let unitType: Int
    let phrase: String?

    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
        case unitType = "UnitType"
        case phrase = "Phrase"
    }
}

extension Value: CustomStringConvertible {
    var description: String {
        let unit = unit == "C" ? "°" : unit
        return "\(String(format: "%.0f", value))\(unit)"
    }
}
