//
//  ViewController.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 10.07.2022.
//

import UIKit

class ForecastSummaryViewController: UIViewController {
    
    let source = NetworkService()
    let location = Location(accuWeatherID: 294021)
    
    private(set) var dailyForecast: DailyForecast? {
        didSet {
            dailyForecastTableView.reloadData()
            currentWeatherViewController?.setup(dayTime: dailyForecast?.dailyForecasts.first?.sun.rise,
                                                sunset: dailyForecast?.dailyForecasts.first?.sun.sunSet)
        }
    }
    private(set) var horlyForecast: [HourlyForecastElement]? {
        didSet {
            hourlyForecastCollectionView.reloadData()
        }
    }
    private(set) var currentConditions: [CurrentCondition]? {
        didSet {
            currentWeatherViewController?.setup(currentCondition: currentConditions?.first)
        }
    }
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var dailyForecastTableView: UITableView!
    @IBOutlet weak var hourlyForecastCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dailyForecastTableView.register(UINib(nibName: "DailyForecastTableViewCell" , bundle: nil), forCellReuseIdentifier: String(describing: DailyForecastTableViewCell.self))
        hourlyForecastCollectionView.register(UINib(nibName: "HourForecastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: String(describing: HourForecastCollectionViewCell.self))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestForecasts()
    }
    
    private func requestForecasts() {
        loadingIndicator.startAnimating()
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            self.source.dailyForecast(location: self.location, queue: .main) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let weather):
                    self.dailyForecast = weather
                case .failure(let error):
                    self.showError(error)
                    print(error)
                }
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            self.source.hourlyForecast(location: self.location, queue: .main) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let weather):
                    self.horlyForecast = weather
                case .failure(let error):
                    self.showError(error)
                    print(error)
                }
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            self.source.currentCondition(location: self.location, queue: .main) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let weather):
                    self.currentConditions = weather
                case .failure(let error):
                    self.showError(error)
                    print(error)
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.loadingIndicator.stopAnimating()
        }
    }
    
    private var currentWeatherViewController: CurrentWeatherViewController? {
        for child in children {
            if let currentWeatherViewController = child as? CurrentWeatherViewController {
                return currentWeatherViewController
            }
        }
        return nil
    }
}
