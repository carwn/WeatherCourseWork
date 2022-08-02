//
//  ViewController.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 10.07.2022.
//

import UIKit

class ForecastSummaryViewController: UIViewController {
    
    var presenter: ForecastSummaryPresenter?
    
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
        presenter?.viewWillAppear()
    }
    
    @IBAction func selectLocationButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Введите город", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Москва"
            textField.text = "Москва"
        }
        alert.addAction(UIAlertAction(title: "Поиск", style: .default, handler: { [weak self] _ in
            self?.presenter?.searchLocation(searchString: alert.textFields?[0].text)
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        present(alert, animated: true)
    }
    
    private var currentWeatherViewController: CurrentWeatherViewController? {
        for child in children {
            if let currentWeatherViewController = child as? CurrentWeatherViewController {
                return currentWeatherViewController
            }
        }
        return nil
    }
    
    private func updateNavigationTitle() {
        guard let location = presenter?.location else {
            navigationItem.title = "Выберете город 👉"
            return
        }
        navigationItem.title = "\(location.localizedName), \(location.country.localizedName)"
    }
}

extension ForecastSummaryViewController {
    func locationDidUpdate() {
        updateNavigationTitle()
    }
    
    func dailyForecastDidUpdate() {
        dailyForecastTableView.reloadData()
        currentWeatherViewController?.setup(dayTime: presenter?.dailyForecast?.dailyForecasts.first?.sun.rise,
                                            sunset: presenter?.dailyForecast?.dailyForecasts.first?.sun.sunSet)
    }
    
    func horlyForecastDidUpdate() {
        hourlyForecastCollectionView.reloadData()
    }
    
    func currentConditionsDidUpdate() {
        currentWeatherViewController?.setup(currentCondition: presenter?.currentConditions?.first)
    }
    
    func startLoadingIndication() {
        loadingIndicator.startAnimating()
    }
    
    func stopLoadingIndication() {
        loadingIndicator.stopAnimating()
    }
}
