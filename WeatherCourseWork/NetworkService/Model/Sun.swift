// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
// let sun = try? newJSONDecoder().decode(Sun.self, from: jsonData)

import Foundation

struct Sun: Codable {
    let rise: Date
//    let epochRise: Int
    let sunSet: Date
//    let epochSet: Int

    enum CodingKeys: String, CodingKey {
        case rise = "Rise"
//        case epochRise = "EpochRise"
        case sunSet = "Set"
//        case epochSet = "EpochSet"
    }
}
