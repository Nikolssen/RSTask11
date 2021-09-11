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
        let rocket = rockets[index]
        return RocketCellViewData(name: rocket.name ,firstLaunch: rocket.firstLaunch, cost: "\(rocket.launchCost)$", success: "\(rocket.successRate)%", imageURL: rocket.images.first, imageCacher: service.imageCacher)
    }
    
    func showDetailsForCell(at index: Int) {
        coordinator.showDetails(model: rockets[index])
    }
    
    func numberOfCells() -> Int {
        return rockets.count
    }
    
    init(service: ServiceType, coordinator: RocketListPresenterCoordinator){
        self.service = service
        self.coordinator = coordinator
    }
    
}
