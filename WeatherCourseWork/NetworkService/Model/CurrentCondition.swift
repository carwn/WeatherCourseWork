// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
// let currentCondition = try? newJSONDecoder().decode(CurrentCondition.self, from: jsonData)

import Foundation

struct CurrentCondition: Codable {
    let localObservationDateTime: Date
//    let epochTime: Int
    let weatherText: String
//    let weatherIcon: Int
//    let hasPrecipitation: Bool
//    let precipitationType: JSONNull?
//    let isDayTime: Bool
    let temperature: MetricImperialValue
//    let realFeelTemperature, realFeelTemperatureShade: MetricImperialValue
//    let relativeHumidity, indoorRelativeHumidity: Int
//    let dewPoint: MetricImperialValue
    let wind: CurrentWind
//    let windGust: CurrentWindGust
//    let uvIndex: Int
//    let uvIndexText: String
//    let visibility: MetricImperialValue
//    let obstructionsToVisibility: String
//    let cloudCover: Int
//    let ceiling, pressure: MetricImperialValue
//    let pressureTendency: PressureTendency
//    let past24HourTemperatureDeparture, apparentTemperature, windChillTemperature, wetBulbTemperature: MetricImperialValue
//    let precip1Hr: MetricImperialValue
    let precipitationSummary: [String: MetricImperialValue]
    let temperatureSummary: TemperatureSummary
//    let mobileLink, link: String

    enum CodingKeys: String, CodingKey {
        case localObservationDateTime = "LocalObservationDateTime"
//        case epochTime = "EpochTime"
        case weatherText = "WeatherText"
//        case weatherIcon = "WeatherIcon"
//        case hasPrecipitation = "HasPrecipitation"
//        case precipitationType = "PrecipitationType"
//        case isDayTime = "IsDayTime"
        case temperature = "Temperature"
//        case realFeelTemperature = "RealFeelTemperature"
//        case realFeelTemperatureShade = "RealFeelTemperatureShade"
//        case relativeHumidity = "RelativeHumidity"
//        case indoorRelativeHumidity = "IndoorRelativeHumidity"
//        case dewPoint = "DewPoint"
        case wind = "Wind"
//        case windGust = "WindGust"
//        case uvIndex = "UVIndex"
//        case uvIndexText = "UVIndexText"
//        case visibility = "Visibility"
//        case obstructionsToVisibility = "ObstructionsToVisibility"
//        case cloudCover = "CloudCover"
//        case ceiling = "Ceiling"
//        case pressure = "Pressure"
//        case pressureTendency = "PressureTendency"
//        case past24HourTemperatureDeparture = "Past24HourTemperatureDeparture"
//        case apparentTemperature = "ApparentTemperature"
//        case windChillTemperature = "WindChillTemperature"
//        case wetBulbTemperature = "WetBulbTemperature"
//        case precip1Hr = "Precip1hr"
        case precipitationSummary = "PrecipitationSummary"
        case temperatureSummary = "TemperatureSummary"
//        case mobileLink = "MobileLink"
//        case link = "Link"
    }
}
