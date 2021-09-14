//
//  LaunchListPresenter.swift
//  RSTask11
//
//  Created by Admin on 11.09.2021.
//

import Foundation

protocol LaunchListPresenterType {
    
    var delegate: LaunchListPresenterDelegate? {get set}
    
    var coordinator: LaunchListPresenterCoordinator {get}
    var service: ServiceType {get}
    
    func viewWillBecomeActive()
    func viewDataForCell(at index: Int) -> LaunchCellViewData
    func showDetailsForCell(at index: Int)
    func numberOfCells() -> Int
}

protocol LaunchListPresenterDelegate: AnyObject {
    func updateCollectionView()
}

protocol LaunchListPresenterCoordinator {
    func showDetails(model: Launch)
}

class LaunchListPresenter: LaunchListPresenterType {
    
    weak var delegate: LaunchListPresenterDelegate?
    let coordinator: LaunchListPresenterCoordinator
    let service: ServiceType
    var launches: [Launch] = []
    
    func viewWillBecomeActive() {
        
        let completion: (Result<[Launch], Error>) -> Void = {[weak self]
            result in
            DispatchQueue.main.async {
                switch result {
                case let .success(launches):
                    self?.launches = launches
                    self?.delegate?.updateCollectionView()
                    
                case .failure(_):
                    print("There is an error")
                }
            }
        }
        
        DispatchQueue.global(qos: .utility).async {
            self.service.networkService.get(request: .launches, callback: completion)
        }
    }
    
    func viewDataForCell(at index: Int) -> LaunchCellViewData {
        let launch = launches[index]
        return LaunchCellViewData(name: launch.name, date: launch.launchDate?.fromExtendedFormatToDate, isPlanned: launch.upcoming, number: "\(launch.flightNumber)", imageURL: launch.links.patch.small, imageCacher: service.imageCacher)
    }
    
    func showDetailsForCell(at index: Int) {
        coordinator.showDetails(model: launches[index])
    }
    
    func numberOfCells() -> Int {
        return launches.count
    }
    
    init(service: ServiceType, coordinator: LaunchListPresenterCoordinator){
        self.service = service
        self.coordinator = coordinator
    }
    
}
