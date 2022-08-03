// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
// let forecast = try? newJSONDecoder().decode(Forecast.self, from: jsonData)

import Foundation

struct Forecast: Codable {
//    let icon: Int
    let iconPhrase: String
//    let hasPrecipitation: Bool
//    let shortPhrase, longPhrase: String
    let precipitationProbability: Int
//    let thunderstormProbability, rainProbability, snowProbability: Int
//    let iceProbability: Int
//    let wind, windGust: Wind
//    let totalLiquid, rain, snow, ice: Value
//    let hoursOfPrecipitation, hoursOfRain, hoursOfSnow, hoursOfIce: Double
//    let cloudCover: Int
//    let evapotranspiration, solarIrradiance: Value
//    let precipitationType, precipitationIntensity: String?

    enum CodingKeys: String, CodingKey {
//        case icon = "Icon"
        case iconPhrase = "IconPhrase"
//        case hasPrecipitation = "HasPrecipitation"
//        case shortPhrase = "ShortPhrase"
//        case longPhrase = "LongPhrase"
        case precipitationProbability = "PrecipitationProbability"
//        case thunderstormProbability = "ThunderstormProbability"
//        case rainProbability = "RainProbability"
//        case snowProbability = "SnowProbability"
//        case iceProbability = "IceProbability"
//        case wind = "Wind"
//        case windGust = "WindGust"
//        case totalLiquid = "TotalLiquid"
//        case rain = "Rain"
//        case snow = "Snow"
//        case ice = "Ice"
//        case hoursOfPrecipitation = "HoursOfPrecipitation"
//        case hoursOfRain = "HoursOfRain"
//        case hoursOfSnow = "HoursOfSnow"
//        case hoursOfIce = "HoursOfIce"
//        case cloudCover = "CloudCover"
//        case evapotranspiration = "Evapotranspiration"
//        case solarIrradiance = "SolarIrradiance"
//        case precipitationType = "PrecipitationType"
//        case precipitationIntensity = "PrecipitationIntensity"
    }
}
