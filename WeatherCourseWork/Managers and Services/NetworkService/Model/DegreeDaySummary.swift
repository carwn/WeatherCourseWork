// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
// let degreeDaySummary = try? newJSONDecoder().decode(DegreeDaySummary.self, from: jsonData)

import Foundation

struct DegreeDaySummary: Codable {
    let heating, cooling: Value

    enum CodingKeys: String, CodingKey {
        case heating = "Heating"
        case cooling = "Cooling"
    }
}
