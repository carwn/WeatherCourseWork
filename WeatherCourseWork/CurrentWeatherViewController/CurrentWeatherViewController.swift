//
//  CurrentWeatherViewController.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 13.07.2022.
//

import UIKit

class CurrentWeatherViewController: UIViewController {
    
    var currentConditions: CurrentConditions? {
        didSet {
            setupForCurrentConditions()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 5
        setupForCurrentConditions()
    }
    
    private func setupForCurrentConditions() {
        print("CurrentConditions setted:", currentConditions?.description as Any)
    }
}
