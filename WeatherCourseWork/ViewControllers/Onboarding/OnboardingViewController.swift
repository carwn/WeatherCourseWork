//
//  OnboardingViewController.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 04.08.2022.
//

import UIKit

class OnboardingViewController: UIViewController {
    var presenter: OnboardingPresenter?
    
    @IBAction func useLocationButtonPressed(_ sender: Any) {
        presenter?.useLocationButtonPressed()
    }
    
    @IBAction func dontUseLocationButtonPressed(_ sender: Any) {
        presenter?.dontUseLocationButtonPressed()
    }
}
