//
//  RocketListPresenter.swift
//  RSTask11
//
//  Created by Admin on 11.09.2021.
//

import Foundation

protocol RocketListPresenterType {
    
    var delegate: RocketListPresenterDelegate? {get set}
    
    var coordinator: RocketListPresenterCoordinator {get}
    var service: ServiceType {get}
    
    func viewWillBecomeActive()
    func viewDataForCell(at index: Int) -> RocketCellViewData
    func showDetailsForCell(at index: Int)
    func numberOfCells() -> Int
    func sort(by options: Rocket.SortingOptions)
}

protocol RocketListPresenterDelegate: AnyObject {
    func updateCollectionView()
}

protocol RocketListPresenterCoordinator {
    func showDetails(model: Rocket)
}

class RocketListPresenter: RocketListPresenterType {
    
    weak var delegate: RocketListPresenterDelegate?
    let coordinator: RocketListPresenterCoordinator
    let service: ServiceType
    var rockets: [Rocket] = []
    private var displayRockets: [Rocket] = []
    var sortingOption: Rocket.SortingOptions?
    
    func viewWillBecomeActive() {
        
        let completion: (Result<[Rocket], Error>) -> Void = {[weak self]
            result in
            DispatchQueue.main.async {
                switch result {
                case let .success(rockets):
                    self?.rockets = rockets
                    self?.delegate?.updateCollectionView()
                    
                case .failure(_):
                    print("There is an error")
                }
            }
        }
        
        DispatchQueue.global(qos: .utility).async {
            self.service.networkService.get(request: .rockets, callback: completion)
        }
    }
    
    func viewDataForCell(at index: Int) -> RocketCellViewData {
        
        let rocket = displayRockets.isEmpty ? rockets[index] : displayRockets[index]
        return RocketCellViewData(name: rocket.name ,firstLaunch: rocket.firstLaunch.toDateFormat,
                                  cost: "\(rocket.launchCost)$", success: "\(rocket.successRate)%", imageURL: rocket.images.first, imageCacher: service.imageCacher)
    }
    
    func showDetailsForCell(at index: Int) {
        let rocket = displayRockets.isEmpty ? rockets[index] : displayRockets[index]
        coordinator.showDetails(model: rocket)
        
    }
    
    func numberOfCells() -> Int {
        return rockets.count
    }
    
    func sort(by options: Rocket.SortingOptions) {
        var sortingClosure: ((Rocket, Rocket) -> Bool)? = nil
        switch options {
        case .launchCost:
            if let sortingOption = sortingOption, options == sortingOption {
                sortingClosure = {$0.launchCost < $1.launchCost}
                self.sortingOption = nil
            }
            else {
                sortingClosure = {$0.launchCost > $1.launchCost}
                self.sortingOption = options
            }
            
        case .firstLaunch:
            if  let sortingOption = sortingOption, options == sortingOption {
                sortingClosure = { !String.compareDates(date1: $0.firstLaunch, date2: $1.firstLaunch) }
                self.sortingOption = nil
            }
            else {
                sortingClosure = { String.compareDates(date1: $0.firstLaunch, date2: $1.firstLaunch) }
                self.sortingOption = options
            }
           
        case .success:
            if  let sortingOption = sortingOption, options == sortingOption {
                sortingClosure = { $0.successRate < $1.successRate }
                self.sortingOption = nil
            }
            else {
                sortingClosure = { $0.successRate > $1.successRate }
                self.sortingOption = options
            }
        }
        if let sortingClosure = sortingClosure {
            self.displayRockets = rockets.sorted(by: sortingClosure)
            delegate?.updateCollectionView()
        }
    }
    init(service: ServiceType, coordinator: RocketListPresenterCoordinator){
        self.service = service
        self.coordinator = coordinator
    }
    
}
