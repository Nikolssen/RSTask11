//
//  LaunchDetailsPresenter.swift
//  RSTask11
//
//  Created by Ivan Budovich on 9/13/21.
//

import Foundation
import UIKit

protocol LaunchDetailsPresenterType {
    var title: String {get}
    var isPlanned: Bool {get}
    var number: String {get}
    var description: String? {get}
    var staticFireDate: String? {get}
    var launchDate: String? {get}
    var success: Bool? {get}
    
    var rocketViewData: RocketCellViewData? {get}
    
    var numberOfImages: Int {get}
    func imageSelected(at index: Int)
    
    
    func showWikipediaPage()
    func showYoutubePage()
    func showRecoveryPage()
    func showMediaPage()
    func showCampaignPage()
    func showLaunchPage()
    
    func loadTitleImage(callback: @escaping (UIImage) -> Void)
    func loadImageForCell(at index: Int, callback: @escaping (UIImage) -> Void)
    
    
}

protocol LaunchDetailsCoordinator {
    func showFullscreenImage(with url: String)
    func openWebViewLink(with url: String)
}

class LaunchDetailsPresenter: LaunchDetailsPresenterType {

    
    
    let service: ServiceType
    let coordinator: LaunchDetailsCoordinator
    let rocket: Rocket?
    let launch: Launch
    
    var title: String {
        launch.name
    }
    
    var isPlanned: Bool {
        launch.upcoming
    }
    
    var number: String {
        "\(launch.flightNumber)"
    }
    
    var description: String? {
        launch.details
    }
    
    var staticFireDate: String? {
        launch.staticFireDate?.fromExtendedFormatToDate
    }
    
    var launchDate: String? {
        launch.launchDate?.fromExtendedFormatToDate
    }
    
    var success: Bool? {
        launch.success
    }
    
    var rocketViewData: RocketCellViewData? {
        guard let rocket = rocket else { return nil }
        return RocketCellViewData(name: rocket.name ,firstLaunch: rocket.firstLaunch.toDateFormat, cost: "\(rocket.launchCost)$", success: "\(rocket.successRate)%", imageURL: rocket.images.first, imageCacher: service.imageCacher)
    }
    
    func showWikipediaPage() {
        
    }
    
    func showYoutubePage() {
        
    }
    
    func showRecoveryPage() {
        
    }
    
    func showMediaPage() {
        
    }
    
    func showCampaignPage() {
        
    }
    
    func showLaunchPage() {
        
    }
    
    func imageSelected(at index: Int) {
        coordinator.showFullscreenImage(with: launch.links.flickr.original![index])
    }
    
    func loadImageForCell(at index: Int, callback: @escaping (UIImage) -> Void) {
        service.imageCacher.loadImage(urlString: launch.links.flickr.original![index], completion: callback)
    }
    
    func loadTitleImage(callback: @escaping (UIImage) -> Void) {
        if let url = launch.links.flickr.original?.first {
            service.imageCacher.loadImage(urlString: url, completion: callback)
        }
       
    }
    var numberOfImages: Int {
        return launch.links.flickr.original?.count ?? 0
    }
    
    init(service: ServiceType, model: Launch, rocket: Rocket?, coordinator: LaunchDetailsCoordinator) {
        self.service = service
        self.launch = model
        self.rocket = rocket
        self.coordinator = coordinator
    }
    
}
