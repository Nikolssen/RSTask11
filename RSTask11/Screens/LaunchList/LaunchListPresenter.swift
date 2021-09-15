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
    func sort(by options: Launch.SortingOptions)
    func filter(by options: Launch.FilterOptions)
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
    private var displayedLaunches: [Launch] = []
    private var filterOption: Launch.FilterOptions = .all
    private var sortingOption: Launch.SortingOptions?
    private var sortDescending = true
    
    func viewWillBecomeActive() {
        if launches.isEmpty {
            let completion: (Result<[Launch], Error>) -> Void = {[weak self]
                result in
                DispatchQueue.main.async {
                    switch result {
                    case let .success(launches):
                        self?.launches = launches
                        self?.displayedLaunches = launches
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
    }
    
    func viewDataForCell(at index: Int) -> LaunchCellViewData {
        let launch = displayedLaunches[index]
        return LaunchCellViewData(name: launch.name, date: launch.launchDate?.fromExtendedFormatToDate, isPlanned: launch.upcoming, number: "\(launch.flightNumber)", imageURL: launch.links.patch.small, imageCacher: service.imageCacher)
    }
    
    func showDetailsForCell(at index: Int) {
        coordinator.showDetails(model: displayedLaunches[index])
    }
    
    func numberOfCells() -> Int {
        return displayedLaunches.count
    }
    func sort(array: [Launch], by options: Launch.SortingOptions) -> [Launch] {
        var sortingClosure: ((Launch, Launch) -> Bool)? = nil
        switch options {
        case .number:
            if (sortingOption == options && sortDescending) {
                sortingClosure = {$0.flightNumber > $1.flightNumber}
            } else
            if (sortingOption == options && !sortDescending) {
                sortingClosure = {$0.flightNumber < $1.flightNumber}
            }
            else {
                sortingClosure = {$0.flightNumber > $1.flightNumber}
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
        case .launchDate:
            if (sortingOption == options && sortDescending) {
                sortingClosure = { String.compareExtendedDates(date1: $0.launchDate, date2: $1.launchDate) }
            } else
            if (sortingOption == options && !sortDescending) {
                sortingClosure = {!String.compareExtendedDates(date1: $0.launchDate, date2: $1.launchDate)}
            }
            else {
                sortingClosure = {String.compareExtendedDates(date1: $0.launchDate, date2: $1.launchDate)}
            }
        }
        if let sortingClosure = sortingClosure {
            return array.sorted(by: sortingClosure)
        }
        else {return array}
    }
    
    func filter(array: [Launch], by options: Launch.FilterOptions) -> [Launch] {
        switch options {
        case .all:
            return array
        case .future:
            let newArray = array.filter({$0.upcoming})
            return newArray
        case .past:
            let newArray = array.filter({!$0.upcoming})
            return newArray
        }
    }
    
    func sort(by options: Launch.SortingOptions) {
        let filteredArray = filter(array: launches, by: filterOption)
        if options == sortingOption {
            sortDescending.toggle()
        }
        else {
            if sortingOption != nil {
                sortDescending = true
            }
        }
        displayedLaunches = sort(array: filteredArray, by: options)

        sortingOption = options
        delegate?.updateCollectionView()
    }
    
    func filter(by options: Launch.FilterOptions) {
        let filteredArray = filter(array: launches, by: options)
        filterOption = options
        if let sortingOption = sortingOption {
            displayedLaunches = sort(array: filteredArray, by: sortingOption)
        }
        else {
            displayedLaunches =  filteredArray
        }
        delegate?.updateCollectionView()
    }
    
    
    init(service: ServiceType, coordinator: LaunchListPresenterCoordinator){
        self.service = service
        self.coordinator = coordinator
    }
    
}
