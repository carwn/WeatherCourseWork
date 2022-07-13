//
//  UIViewController+showError.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 12.07.2022.
//

import UIKit

extension UIViewController {
    func showError(_ string: String) {
        present(UIAlertController.errorAlert(message: string), animated: true)
    }
    
    func showError(_ error: Error) {
        showError(error.localizedDescription)
    }
}
