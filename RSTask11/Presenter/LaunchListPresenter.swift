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
