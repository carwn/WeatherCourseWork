//
//  UIAlertController+infoAlert.swift
//  Netology iOS homeworks
//
//  Created by Александр on 11.12.2021.
//

import UIKit

extension UIAlertController {
    static func infoAlert(title: String, message: String? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        return alert
    }
    
    static func errorAlert(message: String) -> UIAlertController {
        UIAlertController.infoAlert(title: "Ошибка", message: message)
    }
}
