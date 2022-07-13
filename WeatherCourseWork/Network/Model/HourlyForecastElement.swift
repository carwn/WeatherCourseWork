// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let hourlyForecastElement = try? newJSONDecoder().decode(HourlyForecastElement.self, from: jsonData)

import Foundation

// MARK: - HourlyForecastElement
struct HourlyForecastElement: Codable {
    let dateTime: Date
    let epochDateTime, weatherIcon: Int
    let iconPhrase: String
    let hasPrecipitation, isDaylight: Bool
    let temperature, realFeelTemperature, realFeelTemperatureShade, wetBulbTemperature: Value
    let dewPoint: Value
    let wind: Wind
    let windGust: WindGust
    let relativeHumidity, indoorRelativeHumidity: Int
    let visibility, ceiling: Value
    let uvIndex: Int
    let uvIndexText: String
    let precipitationProbability, thunderstormProbability, rainProbability, snowProbability: Int
    let iceProbability: Int
    let totalLiquid, rain, snow, ice: Value
    let cloudCover: Int
    let evapotranspiration, solarIrradiance: Value
    let mobileLink, link: String

    enum CodingKeys: String, CodingKey {
        case dateTime = "DateTime"
        case epochDateTime = "EpochDateTime"
        case weatherIcon = "WeatherIcon"
        case iconPhrase = "IconPhrase"
        case hasPrecipitation = "HasPrecipitation"
        case isDaylight = "IsDaylight"
        case temperature = "Temperature"
        case realFeelTemperature = "RealFeelTemperature"
        case realFeelTemperatureShade = "RealFeelTemperatureShade"
        case wetBulbTemperature = "WetBulbTemperature"
        case dewPoint = "DewPoint"
        case wind = "Wind"
        case windGust = "WindGust"
        case relativeHumidity = "RelativeHumidity"
        case indoorRelativeHumidity = "IndoorRelativeHumidity"
        case visibility = "Visibility"
        case ceiling = "Ceiling"
        case uvIndex = "UVIndex"
        case uvIndexText = "UVIndexText"
        case precipitationProbability = "PrecipitationProbability"
        case thunderstormProbability = "ThunderstormProbability"
        case rainProbability = "RainProbability"
        case snowProbability = "SnowProbability"
        case iceProbability = "IceProbability"
        case totalLiquid = "TotalLiquid"
        case rain = "Rain"
        case snow = "Snow"
        case ice = "Ice"
        case cloudCover = "CloudCover"
        case evapotranspiration = "Evapotranspiration"
        case solarIrradiance = "SolarIrradiance"
        case mobileLink = "MobileLink"
        case link = "Link"
    }
}
