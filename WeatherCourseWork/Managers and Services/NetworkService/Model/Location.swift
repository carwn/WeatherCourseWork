// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
// let location = try? newJSONDecoder().decode(Location.self, from: jsonData)

import Foundation

struct Location: Codable {
    let key: String
    let localizedName: String
    let country: Country

    enum CodingKeys: String, CodingKey {
        case key = "Key"
        case localizedName = "LocalizedName"
        case country = "Country"
    }
}
