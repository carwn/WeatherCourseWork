// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let windGust = try? newJSONDecoder().decode(WindGust.self, from: jsonData)

import Foundation

// MARK: - WindGust
struct WindGust: Codable {
    let speed: Evapotranspiration

    enum CodingKeys: String, CodingKey {
        case speed = "Speed"
    }
}
