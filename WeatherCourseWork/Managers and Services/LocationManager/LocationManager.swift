//
//  LocationManager.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 04.08.2022.
//

import MapKit
import CoreLocation

import Foundation

class LocationManager: NSObject {
    
    private let networkService: NetworkService
    private let locationManager = CLLocationManager()
    private var completion: ((Result<Location, LocationManagerError>) -> Void)?
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getCurrentLocation(completion: @escaping (Result<Location, LocationManagerError>) -> Void) {
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            self.completion = completion
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.startUpdatingLocation()
        } else {
            completion(.failure(.cantGetLocation))
        }
    }
    
    private func makeLocation(coordinate: CLLocationCoordinate2D) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        CLGeocoder().reverseGeocodeLocation(location) { [weak self] placemarks, error in
            if let locality = placemarks?.first?.locality {
                self?.networkService.locations(searchString: locality) { [weak self] result in
                    switch result {
                    case .success(let locations):
                        if let location = locations.first {
                            self?.completion?(.success(location))
                        } else {
                            self?.completion?(.failure(.cantGetTitleFromCoordinate))
                        }
                    case .failure(let error):
                        self?.completion?(.failure(.other(error)))
                    }
                }
            } else if let error = error {
                self?.completion?(.failure(.other(error)))
            } else {
                self?.completion?(.failure(.cantGetTitleFromCoordinate))
            }
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue = manager.location?.coordinate else {
            completion?(.failure(.cantGetLocation))
            return
        }
        makeLocation(coordinate: locValue)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completion?(.failure(.other(error)))
    }
}
