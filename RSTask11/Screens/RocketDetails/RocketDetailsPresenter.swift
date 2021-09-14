//
//  RocketDetailsPresenter.swift
//  RSTask11
//
//  Created by Ivan Budovich on 9/13/21.
//

import Foundation
import UIKit

protocol RocketDetailsPresenterType {
    var title: String {get}
    var description: String {get}
    var firstLaunch: String {get}
    var launchCost: String {get}
    var successRate: String {get}
    var mass: String {get}
    var height: String {get}
    var diameter: String {get}
    
    var firstStageReusable: String {get}
    var firstStageEnginesAmount: String {get}
    var firstStageFuelAmount: String {get}
    var firstStageBurningTime: String? {get}
    var firstStageSeaLevelThrust: String {get}
    var firstStageVacuumThrust: String {get}
    
    var secondStageReusable: String {get}
    var secondStageEnginesAmount: String {get}
    var secondStageFuelAmount: String {get}
    var secondStageBurningTime: String? {get}
    var secondStageThrust: String {get}
    
    var langingLegs: (String, String)? {get}
    
    var engineType: String {get}
    var engineLayout: String? {get}
    var engineAmount: String {get}
    var engineVersion: String {get}
    var enginePropellant1: String {get}
    var enginePropellant2: String {get}
    
    var numberOfImages: Int {get}
    func imageSelected(at index: Int)
    func showWikipediaPage()
    func loadTitleImage(callback: @escaping (UIImage) -> Void)
    func loadImageForCell(at index: Int, callback: @escaping (UIImage) -> Void)
}

protocol DetailsCoordinator {
    func showFullscreenImage(with url: String)
    func openWebViewLink(with url: String)
}

class RocketDetailsPresenter: RocketDetailsPresenterType {
 
    let service: ServiceType
    let coordinator: DetailsCoordinator
    let rocket: Rocket
    
    var title: String{
        rocket.name
    }
    
    var description: String {
        rocket.description
    }
    
    var firstLaunch: String {
        rocket.firstLaunch.toDateFormat
    }
    
    var launchCost: String {
        "\(rocket.launchCost)$"
    }
    
    var successRate: String {
        "\(rocket.successRate)%"
    }
    
    var mass: String {
        "\(rocket.mass)kg"
    }
    
    var height: String {
        "\(rocket.height) meters"
    }
    
    var diameter: String{
        "\(rocket.height) meters"
    }
    
    var firstStageReusable: String {
        rocket.firstStage.isReusable ? "Yes" : "No"
    }
    
    var firstStageEnginesAmount: String{
        "\(rocket.firstStage.engines)"
    }
    
    var firstStageFuelAmount: String{
        "\(rocket.firstStage.fuel) tons"
    }
    
    var firstStageBurningTime: String? {
        if let burningTime = rocket.firstStage.burnTime {
            return "\(burningTime) seconds"
        }
        return nil
    }
    
    var firstStageSeaLevelThrust: String {
        "\(rocket.firstStage.thrustSeaLevel) kN"
    }
    
    var firstStageVacuumThrust: String {
        "\(rocket.firstStage.thrustVacuum) kN"
    }
    
    var secondStageReusable: String {
        rocket.secondStage.isReusable ? "Yes" : "No"
    }
    
    var secondStageEnginesAmount: String {
        "\(rocket.secondStage.engines)"
    }
    
    var secondStageFuelAmount: String {
        "\(rocket.secondStage.fuel) tons"
    }
    
    var secondStageBurningTime: String? {
        if let burningTime = rocket.secondStage.burnTime {
            return "\(burningTime) seconds"
        }
        return nil
    }
    
    var secondStageThrust: String {
        "\(rocket.secondStage.thrust) kN"
    }
    
    var langingLegs: (String, String)? {
        if let landingLegs = rocket.landingLegs {
            return ("\(landingLegs.number)", landingLegs.material)
        }
        return nil
    }
    
    var engineType: String {
        rocket.engine.type
    }
    
    var engineLayout: String? {
        rocket.engine.layout
    }
    
    var engineAmount: String {
        "\(rocket.engine.number)"
    }
    
    var engineVersion: String {
        rocket.engine.version
    }
    
    var enginePropellant1: String {
        rocket.engine.propellant1
    }
    
    var enginePropellant2: String {
        rocket.engine.propellant2
    }
    
    func imageSelected(at index: Int) {
        coordinator.showFullscreenImage(with: rocket.images[index])
    }
    
    func showWikipediaPage() {
        coordinator.openWebViewLink(with: rocket.wikipediaLink)
    }
    
    func loadImageForCell(at index: Int, callback: @escaping (UIImage) -> Void) {
        service.imageCacher.loadImage(urlString: rocket.images[index], completion: callback)
    }
    
    func loadTitleImage(callback: @escaping (UIImage) -> Void) {
        if let url = rocket.images.first {
            service.imageCacher.loadImage(urlString: url, completion: callback)
        }
       
    }
    var numberOfImages: Int {
        return rocket.images.count
    }
    
    init(service: ServiceType, model: Rocket, coordinator: DetailsCoordinator) {
        self.service = service
        self.rocket = model
        self.coordinator = coordinator
    }
    
}
