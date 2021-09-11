//
//  LaunchpadListPresenter.swift
//  RSTask11
//
//  Created by Ivan Budovich on 9/10/21.
//

import Foundation

protocol LaunchpadListPresenterType {
    
    var delegate: LaunchpadListPresenterDelegate? {get set}
    
    var coordinator: LaunchpadListPresenterCoordinator {get}
    var service: ServiceType {get}
    
    func viewWillBecomeActive()
    func viewDataForCell(at index: Int) -> LaunchpadCellViewData
    func showDetailsForCell(at index: Int)
    func numberOfCells() -> Int
}

protocol LaunchpadListPresenterDelegate: AnyObject {
    func updateCollectionView()
}

protocol LaunchpadListPresenterCoordinator {
    func showDetails(model: Launchpad)
}

class LaunchpadListPresenter: LaunchpadListPresenterType {
    
    weak var delegate: LaunchpadListPresenterDelegate?
    let coordinator: LaunchpadListPresenterCoordinator
    let service: ServiceType
    var launchpads: [Launchpad] = []
    
    func viewWillBecomeActive() {
        
        let completion: (Result<[Launchpad], Error>) -> Void = {[weak self]
            result in
            DispatchQueue.main.async {
                switch result {
                case let .success(launchpads):
                    self?.launchpads = launchpads
                    self?.delegate?.updateCollectionView()
                    
                case .failure(_):
                    print("There is an error")
                }
            }
        }
        
        DispatchQueue.global(qos: .utility).async {
            self.service.networkService.get(request: .launchpads, callback: completion)
        }
    }
    
    func viewDataForCell(at index: Int) -> LaunchpadCellViewData {
        let launchpad = launchpads[index]
        return LaunchpadCellViewData(name: launchpad.name, location: launchpad.region, status: launchpad.status)
    }
    
    func showDetailsForCell(at index: Int) {
        coordinator.showDetails(model: launchpads[index])
    }
    
    func numberOfCells() -> Int {
        return launchpads.count
    }
    
    init(service: ServiceType, coordinator: LaunchpadListPresenterCoordinator){
        self.service = service
        self.coordinator = coordinator
    }
    
}
