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
    
    private func lsLocations(_ completion: (Result<[LSLocation], LocalStoreError>) -> Void) {
        let fr = LSLocation.fetchRequest()
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
