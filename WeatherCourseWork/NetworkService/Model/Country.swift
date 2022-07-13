// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
// let country = try? newJSONDecoder().decode(Country.self, from: jsonData)

import Foundation

struct Country: Codable {
    let id, localizedName, englishName: String

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case localizedName = "LocalizedName"
        case englishName = "EnglishName"
    }
}
