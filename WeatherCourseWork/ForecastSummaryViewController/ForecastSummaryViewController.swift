//
//  ViewController.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 10.07.2022.
//

import UIKit

class ForecastSummaryViewController: UIViewController {
    
    let source = WeatherSource()
    var dailyForecast: DailyForecast? {
        didSet {
            dailyForecastTableView.reloadData()
        }
    }
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var dailyForecastTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dailyForecastTableView.register(UINib(nibName: "DailyForecastTableViewCell" , bundle: nil), forCellReuseIdentifier: String(describing: DailyForecastTableViewCell.self))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadingIndicator.startAnimating()
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            let location = Location(accuWeatherID: 294021)
            self.source.dailyForecast(location: location, queue: .main) { [weak self] result in
                guard let self = self else { return }
                self.loadingIndicator.stopAnimating()
                switch result {
                case .success(let weather):
                    self.dailyForecast = weather
                    print(weather)
                case .failure(let error):
                    self.present(UIAlertController.errorAlert(message: error.localizedDescription), animated: true)
                    print(error)
                }
            }
        }
    }
}
