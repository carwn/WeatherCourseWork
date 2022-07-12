//
//  ForecastSummaryViewController+tableView.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 12.07.2022.
//

import UIKit

extension ForecastSummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dailyForecast?.dailyForecasts.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DailyForecastTableViewCell.self), for: indexPath) as! DailyForecastTableViewCell
        if let dailyForecast = dailyForecast?.dailyForecasts[indexPath.row] {
            cell.configure(dailyForecast)
        }
        return cell
    }
}

extension ForecastSummaryViewController: UITableViewDelegate {
    
}
