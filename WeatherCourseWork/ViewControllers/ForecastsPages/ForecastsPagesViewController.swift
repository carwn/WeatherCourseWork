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
    private var pageControl: UIPageControl? {
        for view in view.subviews {
            if let pageControl = view as? UIPageControl {
                return pageControl
            }
        }
        return nil
    }
    
    private var titleLabel: UILabel!
    private var subtitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "settingsIcon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(settingsButtonPressed(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "geoIcon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(selectLocationButtonPressed(_:)))
        navigationItem.titleView = titlesView()
        addLoadingIndicator()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updatePageControlDotsDesign()
    }
    
    func updateNavigationTitle(location: Location?) {
        guard let location = location else {
            titleLabel.text = "Выберете город 👉"
            return
        }
        titleLabel.text = "\(location.localizedName), \(location.country.localizedName)"
    }
    
    func startLoadingIndication() {
        guard isViewLoaded else { return }
        loadingIndicator.startAnimating()
    }
    
    func stopLoadingIndication() {
        guard isViewLoaded else { return }
        loadingIndicator.stopAnimating()
    }
    
    func updateLastForecastUpdateDate(_ date: Date?) {
        let dateString: String
        if let date = date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .short
            dateString = dateFormatter.string(from: date)
        } else {
            dateString = "неизвестно"
        }
        subtitleLabel.text = dateString
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
    
    private func titlesView() -> UIView {
        let one = UILabel()
        one.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        
        let two = UILabel()
        two.font = UIFont.systemFont(ofSize: 12)
        
        let stackView = UIStackView(arrangedSubviews: [one, two])
        stackView.distribution = .equalCentering
        stackView.axis = .vertical
        stackView.alignment = .center
        
        self.titleLabel = one
        self.subtitleLabel = two
        
        return stackView
    }
    
    func updatePageControlDotsDesign() {
        pageControl?.customPageControl(dotFillColor: UIColor.almostBlackColor, dotBorderColor: UIColor.almostBlackColor, dotBorderWidth: 1)
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
