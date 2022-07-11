// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
// let headline = try? newJSONDecoder().decode(Headline.self, from: jsonData)

import Foundation

struct Headline: Codable {
    let effectiveDate: Date
    let effectiveEpochDate, severity: Int
    let text, category: String
    let endDate: Date
    let endEpochDate: Int
    let mobileLink, link: String

    enum CodingKeys: String, CodingKey {
        case effectiveDate = "EffectiveDate"
        case effectiveEpochDate = "EffectiveEpochDate"
        case severity = "Severity"
        case text = "Text"
        case category = "Category"
        case endDate = "EndDate"
        case endEpochDate = "EndEpochDate"
        case mobileLink = "MobileLink"
        case link = "Link"
    }
}
