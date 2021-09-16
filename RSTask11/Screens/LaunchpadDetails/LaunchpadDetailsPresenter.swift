//
//  LaunchpadDetailsPresenter.swift
//  RSTask11
//
//  Created by Ivan Budovich on 9/14/21.
//

import Foundation
import UIKit

protocol LaunchpadDetailsPresenterType {
    var title: String {get}
    var fullName: String {get}
    var status: String {get}
    var description: String {get}
    var region: String {get}
    var location: String {get}
    var launchAttempts: String {get}
    var launchSuccess: String {get}
    
    var numberOfImages: Int {get}
    var coordinates: (Double, Double) {get}
    
    var areRocketsAvailable: Bool {get}
    var areLaunchesAvaliable: Bool {get}
    func imageSelected(at index: Int)
    func loadImageForCell(at index: Int, callback: @escaping (UIImage) -> Void)
    func showLaunches()
    func showRockets()
}

protocol LaunchpadDetailsCoordinator: DetailsCoordinator {
    func showRockets(with ids: [String])
    
    func showLaunches(with ids: [String])
}

class LaunchpadDetailsPresenter: LaunchpadDetailsPresenterType{
    func showLaunches() {
        if !launchpad.launches.isEmpty {
            coordinator.showLaunches(with: launchpad.launches)
        }
    }
    
    func showRockets() {
        if !launchpad.rockets.isEmpty {
            coordinator.showRockets(with: launchpad.rockets)
        }
    }
    
    
    
    let launchpad: Launchpad
    let service: ServiceType
    let coordinator: LaunchpadDetailsCoordinator
    
    var title: String {
        launchpad.name
    }
    
    var fullName: String {
        launchpad.fullName
    }
    
    var status: String {
        launchpad.status
    }
    
    var description: String {
        launchpad.details
    }
    
    var region: String {
        launchpad.region
    }
    
    var location: String {
        launchpad.locality
    }
    
    var launchAttempts: String {
        "\(launchpad.launchAttempts)"
    }
    
    var launchSuccess: String {
        "\(launchpad.launchSuccesses)"
    }
    
    var numberOfImages: Int {
        launchpad.images.count
    }
    
    var coordinates: (Double, Double) {
        (launchpad.latitude, launchpad.longitude)
    }
    
    var areRocketsAvailable: Bool {
        !launchpad.rockets.isEmpty
    }
    
    var areLaunchesAvaliable: Bool {
        !launchpad.launches.isEmpty
    }
    
    func loadImageForCell(at index: Int, callback: @escaping (UIImage) -> Void) {
        service.imageCacher.loadImage(urlString: launchpad.images[index], completion: callback)
    }
    func imageSelected(at index: Int) {
        coordinator.showFullscreenImage(with: launchpad.images[index])
    }
    
    init(service: ServiceType, coordinator: LaunchpadDetailsCoordinator, model: Launchpad) {
        self.service = service
        self.coordinator = coordinator
        self.launchpad = model
    }
    
}
