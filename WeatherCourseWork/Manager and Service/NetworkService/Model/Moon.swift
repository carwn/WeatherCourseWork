// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
// let moon = try? newJSONDecoder().decode(Moon.self, from: jsonData)

import Foundation

struct Moon: Codable {
    let rise: Date
    let epochRise: Int
    let moonSet: Date
    let epochSet: Int
    let phase: String
    let age: Int

    enum CodingKeys: String, CodingKey {
        case rise = "Rise"
        case epochRise = "EpochRise"
        case moonSet = "Set"
        case epochSet = "EpochSet"
        case phase = "Phase"
        case age = "Age"
    }
}
