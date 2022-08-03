//
//  CurrentWeatherViewController.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 13.07.2022.
//

import UIKit

class CurrentWeatherViewController: UIViewController {
    
    @IBOutlet weak var temperatureSummaryLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var unknowParameterLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    @IBOutlet weak var dayTimeLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 5
        setup(currentCondition: nil)
        setup(dayTime: nil, sunset: nil)
    }
    
    func setup(currentCondition: CurrentCondition?) {
        temperatureSummaryLabel.text = "\(currentCondition?.temperatureSummary.past24HourRange.minimum.temperatureValue.description ?? "-")/\(currentCondition?.temperatureSummary.past24HourRange.maximum.temperatureValue.description ?? "-")"
        currentTemperatureLabel.text = currentCondition?.temperature.temperatureValue.description ?? "-"
        weatherDescriptionLabel.text = currentCondition?.weatherText ?? "-"
        unknowParameterLabel.text = "-"
        windLabel.text = currentCondition?.wind.speed.windValue.description ?? "-"
        precipitationLabel.text = currentCondition?.precipitationSummary["Precipitation"]?.windValue.description ?? "-"
        dateLabel.text = dateString(from: currentCondition?.localObservationDateTime) ?? "-"
    }
    
    func setup(dayTime: Date?, sunset: Date?) {
        dayTimeLabel.text = timeString(from: dayTime) ?? "-"
        sunsetLabel.text = timeString(from: sunset) ?? "-"
    }
    
    private func timeString(from date: Date?) -> String? {
        guard let date = date else {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = Calendar.current.dateComponents([.timeZone], from: date).timeZone
        return dateFormatter.string(from: date)
    }
    
    private func dateString(from date: Date?) -> String? {
        guard let date = date else {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "ru-ru")
        return dateFormatter.string(from: date)
    }
}
