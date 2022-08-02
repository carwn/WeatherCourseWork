//
//  SettingsViewController.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 02.08.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    var presenter: SettingsPresenter?
    
    @IBAction func setSettingsButtonPressed(_ sender: Any) {
        presenter?.setSettingsButtonPressed()
    }
}
