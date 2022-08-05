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
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
        presenter?.openAppSettings()
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
        guard isViewLoaded else { return }
        dailyForecastTableView.reloadData()
        currentWeatherViewController?.setup(dayTime: presenter?.dailyForecast?.dailyForecasts.first?.sun.rise,
                                            sunset: presenter?.dailyForecast?.dailyForecasts.first?.sun.sunSet)
    }
    
    func horlyForecastDidUpdate() {
        guard isViewLoaded else { return }
        hourlyForecastCollectionView.reloadData()
    }
    
    func currentConditionsDidUpdate() {
        guard isViewLoaded else { return }
        currentWeatherViewController?.setup(currentCondition: presenter?.currentConditions?.first)
    }
    
    func startLoadingIndication() {
        guard isViewLoaded else { return }
        loadingIndicator.startAnimating()
    }
    
    func stopLoadingIndication() {
        guard isViewLoaded else { return }
        loadingIndicator.stopAnimating()
    }
}
