//
//  LocalStore.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 10.08.2022.
//

import Foundation
import CoreData

class LocalStore {
    
    weak var delegate: LocalStoreDelegate?

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WeatherCourseWork")
        container.loadPersistentStores(completionHandler: { [weak self] (storeDescription, error) in
            if let error = error as NSError? {
                self?.delegate?.throwError(error)
            }
        })
        return container
    }()
    
    private var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    var locationsCount: Int {
        do {
            let count = try context.count(for: LSLocation.fetchRequest())
            return count
        } catch {
            delegate?.throwError(error)
            return 0
        }
    }
    
    func locations(_ completion: (Result<[Location], LocalStoreError>) -> Void) {
        lsLocations { result in
            switch result {
            case .success(let lsLocations):
                if !lsLocations.isEmpty {
                    let maped = lsLocations.compactMap { $0.location }
                    if maped.count == lsLocations.count {
                        completion(.success(maped))
                    } else {
                        completion(.failure(.cantParseStoredLocations))
                    }
                } else {
                    completion(.success([]))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func addLocationAsFirst(_ newLocation: Location, completion: (Result<Void, LocalStoreError>) -> Void) {
        lsLocations { result in
            switch result {
            case .success(let locations):
                let firstIndex = locations.first?.sortIndex ?? 0
                addLsLocation(fromLocation: newLocation, atIndex: firstIndex - 1) { result in
                    switch result {
                    case .success(_):
                        completion(.success(()))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func addLocationAsLast(_ newLocation: Location, completion: (Result<Void, LocalStoreError>) -> Void) {
        lsLocations { result in
            switch result {
            case .success(let locations):
                let lastIndex = locations.last?.sortIndex ?? 0
                addLsLocation(fromLocation: newLocation, atIndex: lastIndex + 1) { result in
                    switch result {
                    case .success(_):
                        completion(.success(()))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func saveForecast(_ dailyForecast: DailyForecast, location: Location, completion: ((Result<Void, LocalStoreError>) -> Void)? = nil) {
        saveForecast(dailyForecast, type: .daily, location: location, completion: completion)
    }
    
    func saveForecast(_ hourlyForecasts: [HourlyForecastElement], location: Location, completion: ((Result<Void, LocalStoreError>) -> Void)? = nil) {
        saveForecast(hourlyForecasts, type: .horly, location: location, completion: completion)
    }
    
    func saveForecast(_ currentConditions: [CurrentCondition], location: Location, completion: ((Result<Void, LocalStoreError>) -> Void)? = nil) {
        saveForecast(currentConditions, type: .currentConditions, location: location, completion: completion)
    }
    
    func dailyForecast(location: Location, queue: DispatchQueue = .main, completion: @escaping (Result<(DailyForecast, Date)?, LocalStoreError>) -> Void) {
        forecast(location: location, type: .daily, queue: queue, completion: completion)
    }
    
    func hourlyForecasts(location: Location, queue: DispatchQueue = .main, completion: @escaping (Result<([HourlyForecastElement], Date)?, LocalStoreError>) -> Void) {
        forecast(location: location, type: .horly, queue: queue, completion: completion)
    }
    
    func currentConditions(location: Location, queue: DispatchQueue = .main, completion: @escaping (Result<([CurrentCondition], Date)?, LocalStoreError>) -> Void) {
        forecast(location: location, type: .currentConditions, queue: queue, completion: completion)
    }
    
    private func addLsLocation(fromLocation location: Location, atIndex index: Int64, completion: (Result<LSLocation, LocalStoreError>) -> Void) {
        lsCountry(country: location.country) { result in
            switch result {
            case .success(let country):
                let lsLocation = LSLocation(context: context)
                lsLocation.key = location.key
                lsLocation.localizedName = location.localizedName
                lsLocation.sortIndex = index
                lsLocation.country = country
                do {
                    try saveContext()
                } catch {
                    completion(.failure(.other(error)))
                }
                completion(.success(lsLocation))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func lsLocations(onlyKey: String? = nil, _ completion: (Result<[LSLocation], LocalStoreError>) -> Void) {
        let fr = LSLocation.fetchRequest()
        if let onlyKey = onlyKey {
            fr.predicate = NSPredicate(format: "key == %@", onlyKey)
        }
        fr.sortDescriptors = [NSSortDescriptor(key: #keyPath(LSLocation.sortIndex), ascending: true)]
        do {
            let result = try context.fetch(fr)
            completion(.success(result))
        } catch {
            completion(.failure(.other(error)))
        }
    }
    
    private func lsCountry(country: Country, _ completion: (Result<LSCountry, LocalStoreError>) -> Void) {
        let fr = LSCountry.fetchRequest()
        fr.predicate = NSPredicate(format: "id == %@", country.id)
        do {
            let result = try context.fetch(fr)
            switch result.count {
            case 0, 1:
                let lsCountry = result.first ?? LSCountry(context: context)
                lsCountry.id = country.id
                lsCountry.localizedName = country.localizedName
                lsCountry.englishName = country.englishName
                do {
                    try saveContext()
                } catch {
                    completion(.failure(.other(error)))
                }
                completion(.success(lsCountry))
            default:
                completion(.failure(.moreOneCountryWithID))
            }
        } catch {
            completion(.failure(.other(error)))
        }
    }
    
    private func lsLocation(location: Location, _ completion: (Result<LSLocation, LocalStoreError>) -> Void) {
        lsLocations(onlyKey: location.key) { result in
            switch result {
            case .success(let locations):
                switch locations.count {
                case 0:
                    lastLocationIndex { result in
                        switch result {
                        case .success(let lastIndex):
                            addLsLocation(fromLocation: location, atIndex: lastIndex + 1) { result in
                                switch result {
                                case .success(let location):
                                    completion(.success(location))
                                case .failure(let error):
                                    completion(.failure(error))
                                }
                            }
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                case 1:
                    completion(.success(locations[0]))
                default:
                    completion(.failure(.moreOneLocationWithID))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func forecast<T: Decodable>(location: Location, type: LSForecast.ForecastType, queue: DispatchQueue, completion: @escaping (Result<(T, Date)?, LocalStoreError>) -> Void) {
        lastForecast(location: location, type: type) { result in
            switch result {
            case .success(let forecast):
                if let forecast = forecast {
                    do {
                        let object = try JSONDecoder().decode(T.self, from: forecast.0)
                        queue.async {
                            completion(.success((object, forecast.1)))
                        }
                    } catch {
                        queue.async {
                            completion(.failure(.other(error)))
                        }
                    }
                } else {
                    queue.async {
                        completion(.success(nil))
                    }
                }
            case .failure(let error):
                queue.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    private func lastForecast(location: Location, type: LSForecast.ForecastType, completion: (Result<(Data, Date)?, LocalStoreError>) -> Void) {
        let fr = LSForecast.fetchRequest()
        fr.predicate = NSPredicate(format: "location.key == %@ && type == %@", location.key, type.rawValue)
        fr.sortDescriptors = [NSSortDescriptor(key: #keyPath(LSForecast.date), ascending: true)]
        do {
            let forecasts = try context.fetch(fr)
            if let lastForecast = forecasts.last, let data = lastForecast.json, let date = lastForecast.date {
                completion(.success((data, date)))
            } else {
                completion(.success(nil))
            }
        } catch {
            completion(.failure(.other(error)))
        }
    }
    
    private func saveForecast<T: Encodable>(_ encodable: T, type: LSForecast.ForecastType, location: Location, completion: ((Result<Void, LocalStoreError>) -> Void)? = nil) {
        do {
            let json = try JSONEncoder().encode(encodable)
            saveForecast(date: Date(),
                         json: json,
                         type: type,
                         location: location) { result in
                switch result {
                case .success():
                    break
                case .failure(let error):
                    completion?(.failure(error))
                }
            }
        } catch {
            completion?(.failure(.other(error)))
        }
    }
    
    private func saveForecast(date: Date, json: Data, type: LSForecast.ForecastType, location: Location, completion: (Result<Void, LocalStoreError>) -> Void) {
        lsLocation(location: location) { result in
            switch result {
            case .success(let lsLocation):
                let forecast = LSForecast(context: context)
                forecast.date = date
                forecast.json = json
                forecast.forecastType = type
                forecast.location = lsLocation
                do {
                    try saveContext()
                } catch {
                    completion(.failure(.other(error)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func lastLocationIndex(_ completion: (Result<Int64, LocalStoreError>) -> Void) {
        lsLocations { result in
            switch result {
            case .success(let locations):
                completion(.success(locations.last?.sortIndex ?? 0))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func saveContext() throws {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                throw error
            }
        }
    }
}
