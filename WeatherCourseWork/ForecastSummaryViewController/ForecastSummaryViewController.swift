//
//  ViewController.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 10.07.2022.
//

import UIKit

class ForecastSummaryViewController: UIViewController {
    
    var networkService: NetworkService?
    
    var location: Location? {
        didSet {
            updateNavigationTitle()
            requestForecasts()
        }
    }
    
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
    
    @IBAction func selectLocationButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Введите город", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Москва"
            textField.text = "Москва"
        }
        alert.addAction(UIAlertAction(title: "Поиск", style: .default, handler: { [weak self] _ in
            self?.searchLocation(searchString: alert.textFields?[0].text)
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        present(alert, animated: true)
    }
    
    private func requestForecasts() {
        guard let location = location else {
            dailyForecast = nil
            horlyForecast = nil
            currentConditions = nil
            return
        }
        
        guard let networkService = networkService else {
            showError("Не настроен доступ в сеть")
            return
        }
        
        loadingIndicator.startAnimating()
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            networkService.dailyForecast(location: location, queue: .main) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let weather):
                    self.dailyForecast = weather
                case .failure(let error):
                    self.dailyForecast = nil
                    self.showError(error)
                    print(error)
                }
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            networkService.hourlyForecast(location: location, queue: .main) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let weather):
                    self.horlyForecast = weather
                case .failure(let error):
                    self.horlyForecast = nil
                    self.showError(error)
                    print(error)
                }
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            networkService.currentCondition(location: location, queue: .main) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let weather):
                    self.currentConditions = weather
                case .failure(let error):
                    self.currentConditions = nil
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
    
    private func searchLocation(searchString: String?) {
        guard let networkService = networkService else {
            showError("Не настроен доступ в сеть")
            return
        }
        guard
            let searchString = searchString,
            !searchString.isEmpty
        else {
            showError("Не введена строка для поиска")
            return
        }
        loadingIndicator.startAnimating()
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            networkService.locations(searchString: searchString, queue: .main) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let locations):
                    if !locations.isEmpty {
                        self.location = locations.first
                    } else {
                        self.showError("Не удалось найти город с таким названием")
                    }
                case .failure(let error):
                    self.showError(error)
                    print(error)
                }
                self.loadingIndicator.stopAnimating()
            }
        }
    }
    
    private func updateNavigationTitle() {
        guard let location = location else {
            navigationItem.title = "Выберете город 👉"
            return
        }
        navigationItem.title = "\(location.localizedName), \(location.country.localizedName)"
    }
}
