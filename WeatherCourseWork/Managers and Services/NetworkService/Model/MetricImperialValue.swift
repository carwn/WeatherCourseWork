// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
// let metricImperialValue = try? newJSONDecoder().decode(MetricImperialValue.self, from: jsonData)

import Foundation

struct MetricImperialValue: Codable {
    let metric, imperial: Value

    enum CodingKeys: String, CodingKey {
        case metric = "Metric"
        case imperial = "Imperial"
    }
}
