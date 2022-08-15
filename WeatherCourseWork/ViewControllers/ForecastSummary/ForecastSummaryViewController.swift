//
//  ViewController.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 10.07.2022.
//

import UIKit

class ForecastSummaryViewController: UIViewController {
    
    var presenter: ForecastSummaryPresenter?
    
    @IBOutlet weak var dailyForecastTableView: UITableView!
    @IBOutlet weak var hourlyForecastCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dailyForecastTableView.register(UINib(nibName: "DailyForecastTableViewCell" , bundle: nil), forCellReuseIdentifier: String(describing: DailyForecastTableViewCell.self))
        hourlyForecastCollectionView.register(UINib(nibName: "HourForecastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: String(describing: HourForecastCollectionViewCell.self))
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

extension ForecastSummaryViewController {
    
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
}
