//
//  HourForecastCollectionViewCell.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 12.07.2022.
//

import UIKit

class HourForecastCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var conditionImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2
        layer.borderWidth = 0.5
        layer.borderColor = UIColor(red: 0.671, green: 0.737, blue: 0.918, alpha: 1).cgColor
    }
    
    func configure(_ hourlyForecast: HourlyForecastElement) {
        hourLabel.text = date(for: hourlyForecast)
        conditionImage.image = image(for: hourlyForecast)
        temperatureLabel.text = temperatureDescription(for: hourlyForecast)
    }
    
    private func date(for hourlyForecast: HourlyForecastElement) -> String {
        hourlyForecast.dateTime.timeString
    }
    
    private func image(for hourlyForecast: HourlyForecastElement) -> UIImage? {
        // https://developer.accuweather.com/weather-icons
        switch hourlyForecast.weatherIcon {
        case 1...5, 30...37:
            return hourlyForecast.isDaylight ? UIImage(named: "weatherSun") : UIImage(named: "weatherClearNight")
        case 6...11, 38:
            return UIImage(named: "weatherCloudy")
        case 12...29, 39...44:
            return UIImage(named: "weatherRain")
        default:
            return nil
        }
    }
    
    private func temperatureDescription(for hourlyForecast: HourlyForecastElement) -> String {
        hourlyForecast.temperature.description
    }
}
