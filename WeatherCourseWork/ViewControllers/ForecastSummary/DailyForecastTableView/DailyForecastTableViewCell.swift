//
//  DailyForecastTableViewCell.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 12.07.2022.
//

import UIKit

class DailyForecastTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var precipitationProbabilityLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 16, bottom: 5, right: 16))
        contentView.layer.cornerRadius = 5
    }
    
    func configure(_ dailyForecast: DailyForecastElement) {
        dateLabel.text = date(for: dailyForecast)
        weatherImage.image = image(for: dailyForecast)
        precipitationProbabilityLabel.text = precipitationProbability(for: dailyForecast)
        weatherDescriptionLabel.text = weatherDescription(for: dailyForecast)
        temperatureLabel.text = temperatureDescription(for: dailyForecast)
    }
    
    private func date(for dailyForecast: DailyForecastElement) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        return dateFormatter.string(from: dailyForecast.date)
    }
    
    private func image(for dailyForecast: DailyForecastElement) -> UIImage {
        UIImage(named: "weatherRain")!
    }
    
    private func precipitationProbability(for dailyForecast: DailyForecastElement) -> String {
        "\(dailyForecast.day.precipitationProbability)%"
    }
    
    private func weatherDescription(for dailyForecast: DailyForecastElement) -> String {
        dailyForecast.day.iconPhrase
    }
    
    private func temperatureDescription(for dailyForecast: DailyForecastElement) -> String {
        let minimum = dailyForecast.temperature.minimum.description
        let maximum = dailyForecast.temperature.maximum.description
        return "\(minimum)-\(maximum)"
    }
}
