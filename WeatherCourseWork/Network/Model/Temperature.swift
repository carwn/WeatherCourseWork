// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
// let temperature = try? newJSONDecoder().decode(Temperature.self, from: jsonData)

import Foundation

struct Temperature: Codable {
    let minimum, maximum: Imum

    enum CodingKeys: String, CodingKey {
        case minimum = "Minimum"
        case maximum = "Maximum"
    }
}
