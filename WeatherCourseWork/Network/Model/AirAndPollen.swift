// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
// let airAndPollen = try? newJSONDecoder().decode(AirAndPollen.self, from: jsonData)

import Foundation

struct AirAndPollen: Codable {
    let name: String
    let value: Int
    let category: Category
    let categoryValue: Int
    let type: String?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case value = "Value"
        case category = "Category"
        case categoryValue = "CategoryValue"
        case type = "Type"
    }
}
