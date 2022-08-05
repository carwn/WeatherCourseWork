//
//  OnboardingViewController.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 04.08.2022.
//

import UIKit

class OnboardingViewController: UIViewController {
    var presenter: OnboardingPresenter?
    
    @IBOutlet weak var useLocationButton: UIButton!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    func startCoordinateSearchWaitingUI() {
        useLocationButton.isEnabled = false
        loadingIndicator.startAnimating()
    }
    
    func stopCoordinateSearchWaitingUI() {
        useLocationButton.isEnabled = true
        loadingIndicator.stopAnimating()
    }
    
    @IBAction func useLocationButtonPressed(_ sender: Any) {
        presenter?.useLocationButtonPressed()
    }
    
    @IBAction func dontUseLocationButtonPressed(_ sender: Any) {
        presenter?.dontUseLocationButtonPressed()
    }
}
