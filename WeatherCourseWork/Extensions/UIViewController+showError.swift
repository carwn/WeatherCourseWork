//
//  UIViewController+showError.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 12.07.2022.
//

import UIKit

extension UIViewController {
    func showError(_ error: Error) {
        present(UIAlertController.errorAlert(message: error.localizedDescription), animated: true)
    }
}
