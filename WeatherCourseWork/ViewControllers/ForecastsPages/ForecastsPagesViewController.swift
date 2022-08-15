//
//  ForecastsPagesViewController.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 08.08.2022.
//

import UIKit

class ForecastsPagesViewController: UIPageViewController {
    var presenter: ForecastsPagesPresenter?
    
    private var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "settingsIcon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(settingsButtonPressed(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "geoIcon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(selectLocationButtonPressed(_:)))
        addLoadingIndicator()
    }
    
    func updateNavigationTitle(location: Location?) {
        guard let location = location else {
            navigationItem.title = "Выберете город 👉"
            return
        }
        navigationItem.title = "\(location.localizedName), \(location.country.localizedName)"
    }
    
    func startLoadingIndication() {
        guard isViewLoaded else { return }
        loadingIndicator.startAnimating()
    }
    
    func stopLoadingIndication() {
        guard isViewLoaded else { return }
        loadingIndicator.stopAnimating()
    }
    
    private func addLoadingIndicator() {
        let loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingIndicator)
        NSLayoutConstraint.activate([loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
        self.loadingIndicator = loadingIndicator
    }
    
    @objc private func selectLocationButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Введите город", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Москва"
            textField.text = "Москва"
        }
        alert.addAction(UIAlertAction(title: "Поиск", style: .default, handler: { [weak self] _ in
            self?.presenter?.searchLocation(searchString: alert.textFields?[0].text)
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc private func settingsButtonPressed(_ sender: Any) {
        presenter?.openAppSettings()
    }
}
