//
//  ForecastsPagePresenter.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 08.08.2022.
//

import UIKit

class ForecastsPagesPresenter: NSObject {
    
    private let networkService: NetworkService
    private let coordinator: ApplicationCoordinator
    private let factory: DependencyFactory
    private weak var view: ForecastsPagesViewController?
    
    private var orderedViewControllers: [UIViewController] = []
    private var currentViewController: ForecastSummaryViewController? {
        view?.viewControllers?.first as? ForecastSummaryViewController
    }
    
    init(networkService: NetworkService, coordinator: ApplicationCoordinator, view: ForecastsPagesViewController, factory: DependencyFactory, locations: [Location]) {
        self.networkService = networkService
        self.coordinator = coordinator
        self.factory = factory
        self.view = view
        super.init()
        
        if !locations.isEmpty {
            orderedViewControllers = locations.map { factory.makeForecastSummaryViewController(coordinator: coordinator, location: $0) }
        } else {
            orderedViewControllers = [factory.makeForecastSummaryViewController(coordinator: coordinator, location: nil)]
        }
        view.dataSource = self
        view.delegate = self
        view.setViewControllers([orderedViewControllers.first!], direction: .forward, animated: true)
        view.updateNavigationTitle(location: locations.first)
    }
    
    func searchLocation(searchString: String?) {
        guard
            let searchString = searchString,
            !searchString.isEmpty
        else {
            showError("Не введена строка для поиска")
            return
        }
        startLoadingIndication()
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            self.networkService.locations(searchString: searchString, queue: .main) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let locations):
                    if let location = locations.first {
                        self.coordinator.showForecastForNewLocation(location)
                    } else {
                        self.showError("Не удалось найти город с таким названием")
                    }
                case .failure(let error):
                    self.showError(error)
                    print(error)
                }
                self.stopLoadingIndication()
            }
        }
    }
    
    func openAppSettings() {
        coordinator.openSettings()
    }
    
    func startLoadingIndication() {
        view?.startLoadingIndication()
    }
    
    func stopLoadingIndication() {
        view?.stopLoadingIndication()
    }
    
    func showError(_ error: Error) {
        view?.showError(error)
    }
    
    func showError(_ string: String) {
        view?.showError(string)
    }
    
    func reloadForecasts() {
        currentViewController?.presenter?.reloadForecasts()
        view?.updateNavigationTitle(location: currentViewController?.presenter?.location)
    }
    
    func addPage(location: Location) {
        let newVC = factory.makeForecastSummaryViewController(coordinator: coordinator, location: location)
        orderedViewControllers.append(newVC)
        view?.setViewControllers([newVC], direction: .forward, animated: true)
        view?.updateNavigationTitle(location: location)
    }
}

extension ForecastsPagesPresenter: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        orderedViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let vc = pageViewController.viewControllers?.first else {
            return 0
        }
        return orderedViewControllers.indexOf(vc) ?? 0
    }
}

extension ForecastsPagesPresenter: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        reloadForecasts()
        view?.updatePageControlDotsDesign()
    }
}
