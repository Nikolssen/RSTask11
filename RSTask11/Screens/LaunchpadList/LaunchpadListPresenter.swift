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
    func sort(by options: Launchpad.SortingOptions)
    func filter(by options: Launchpad.FilterOptions)
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
    private var displayedLaunchpads: [Launchpad] = []
    private var filterOption: Launchpad.FilterOptions = .all
    private var sortingOption: Launchpad.SortingOptions?
    private var sortDescending = true
    
    func viewWillBecomeActive() {
        if launchpads.isEmpty {
            let completion: (Result<[Launchpad], Error>) -> Void = {[weak self]
                result in
                DispatchQueue.main.async {
                    switch result {
                    case let .success(launchpads):
                        self?.launchpads = launchpads
                        self?.displayedLaunchpads = launchpads
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
    }
    
    func viewDataForCell(at index: Int) -> LaunchpadCellViewData {
        
        let launchpad = displayedLaunchpads[index]
        return LaunchpadCellViewData(name: launchpad.name, location: launchpad.region, status: launchpad.status)
    }
    
    func showDetailsForCell(at index: Int) {
        let launchpad = displayedLaunchpads[index]
        coordinator.showDetails(model: launchpad)
    }
    
    func numberOfCells() -> Int {
        return displayedLaunchpads.count
    }
    
    init(service: ServiceType, coordinator: LaunchpadListPresenterCoordinator){
        self.service = service
        self.coordinator = coordinator
    }
    
    func sort(array: [Launchpad], by options: Launchpad.SortingOptions) -> [Launchpad] {
        var sortingClosure: ((Launchpad, Launchpad) -> Bool)? = nil
        switch options {
        case .region:
            if (sortingOption == options && sortDescending) {
                sortingClosure = {$0.region > $1.region}
            } else
            if (sortingOption == options && !sortDescending) {
                sortingClosure = {$0.region < $1.region}
            }
            else {
                sortingClosure = {$0.region > $1.region}
            }
        case .status:
            if (sortingOption == options && sortDescending) {
                sortingClosure = {$0.status > $1.status}

            } else
            if (sortingOption == options && !sortDescending) {
                sortingClosure = {$0.status < $1.status}

            }
            else {
                sortingClosure = {$0.status > $1.status}
            }
        case .title:
            if (sortingOption == options && sortDescending) {
                sortingClosure = {$0.name > $1.name}
            } else
            if (sortingOption == options && !sortDescending) {
                sortingClosure = {$0.name < $1.name}
            }
            else {
                sortingClosure = {$0.name > $1.name}
            }
        }
        if let sortingClosure = sortingClosure {
            return array.sorted(by: sortingClosure)
        }
        else {return array}
    }
    
    
    func filter(array: [Launchpad], by options: Launchpad.FilterOptions) -> [Launchpad] {
        switch options {
        case .all:
            return array
        case .active:
            let newArray = array.filter({$0.status == "active"})
            return newArray
        case .retired:
            let newArray = array.filter({$0.status == "retired"})
            return newArray
        }
        
    }
    
    func sort(by options: Launchpad.SortingOptions) {
        let filteredArray = filter(array: launchpads, by: filterOption)
        if options == sortingOption {
            sortDescending.toggle()
        }
        else {
            if sortingOption != nil {
                sortDescending = true
            }
        }
        displayedLaunchpads = sort(array: filteredArray, by: options)

        sortingOption = options
        delegate?.updateCollectionView()
    }
    func filter(by options: Launchpad.FilterOptions) {
        let filteredArray = filter(array: launchpads, by: options)
        filterOption = options
        if let sortingOption = sortingOption {
            displayedLaunchpads = sort(array: filteredArray, by: sortingOption)
        }
        else {
            displayedLaunchpads =  filteredArray
        }
        delegate?.updateCollectionView()
    }
    
}
