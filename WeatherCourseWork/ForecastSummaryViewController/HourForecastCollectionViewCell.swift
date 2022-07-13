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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: hourlyForecast.dateTime)
    }
    
    private func image(for hourlyForecast: HourlyForecastElement) -> UIImage {
        return #imageLiteral(resourceName: "weatherImage.pdf")
    }
    
    private func temperatureDescription(for hourlyForecast: HourlyForecastElement) -> String {
        hourlyForecast.temperature.description
    }
}
