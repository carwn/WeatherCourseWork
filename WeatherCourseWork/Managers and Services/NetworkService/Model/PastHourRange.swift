// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
// let pastHourRange = try? newJSONDecoder().decode(PastHourRange.self, from: jsonData)

import Foundation

struct PastHourRange: Codable {
    let minimum, maximum: MetricImperialValue

    enum CodingKeys: String, CodingKey {
        case minimum = "Minimum"
        case maximum = "Maximum"
    }
}
