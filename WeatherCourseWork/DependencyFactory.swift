//
//  DependencyFactory.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 02.08.2022.
//

import UIKit

class DependencyFactory {
    
    private let networkService = NetworkService()
    private let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    
    func makeForecastSummaryViewController(coordinator: ApplicationCoordinator) -> ForecastSummaryViewController {
        let vc = storyBoard.instantiateViewController(withIdentifier: "ForecastSummaryViewController") as! ForecastSummaryViewController
        let presenter = ForecastSummaryPresenter(networkService: networkService, coordinator: coordinator, view: vc)
        vc.presenter = presenter
        return vc
    }
}
