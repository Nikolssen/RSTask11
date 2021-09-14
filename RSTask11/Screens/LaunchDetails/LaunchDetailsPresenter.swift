//
//  LaunchDetailsPresenter.swift
//  RSTask11
//
//  Created by Ivan Budovich on 9/13/21.
//

import Foundation
import UIKit
enum LaunchMediaContent {
    case wikipedia
    case youtube
    case campaign
    case launch
    case recovery
    case media
}

protocol LaunchDetailsPresenterType {
    var title: String {get}
    var isPlanned: Bool {get}
    var number: String {get}
    var description: String? {get}
    var staticFireDate: String? {get}
    var launchDate: String? {get}
    var success: String? {get}
    var hasRocket: Bool {get}
    var rocketViewData: RocketCellViewData? {get}
    var delegate: LaunchDetailsPresenterDelegate? {get set}
    var numberOfImages: Int {get}
    func imageSelected(at index: Int)
    var hasWikipediaAndYoutube: (Bool, Bool) {get}
    var hasRedditLinks: (Bool, Bool, Bool, Bool) {get}
    func showPage(_ content: LaunchMediaContent)
    func onViewActive()
    func loadTitleImage(callback: @escaping (UIImage) -> Void)
    func loadImageForCell(at index: Int, callback: @escaping (UIImage) -> Void)
    
    
}

protocol LaunchDetailsCoordinator {
    func showFullscreenImage(with url: String)
    func openWebViewLink(with url: String)
}

protocol LaunchDetailsPresenterDelegate: AnyObject {
    func reloadRocket()
}

class LaunchDetailsPresenter: LaunchDetailsPresenterType {
    weak var delegate: LaunchDetailsPresenterDelegate?
    let service: ServiceType
    let coordinator: LaunchDetailsCoordinator
    var rocket: Rocket?
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

    var success: String? {
        if let success = launch.success {
            return success ? "Yes" : "No"
        }
        return nil
    }
    
    var hasRocket: Bool {
        
        launch.rocket != nil
    }
    
    var rocketViewData: RocketCellViewData? {
        guard let rocket = rocket else { return nil }
        return RocketCellViewData(name: rocket.name ,firstLaunch: rocket.firstLaunch.toDateFormat, cost: "\(rocket.launchCost)$", success: "\(rocket.successRate)%", imageURL: rocket.images.first, imageCacher: service.imageCacher)
    }
    
    var hasWikipediaAndYoutube: (Bool, Bool){
        (launch.links.wikipedia != nil, launch.links.youtube != nil)
    }
    var hasRedditLinks: (Bool, Bool, Bool, Bool){
        (launch.links.reddit.recovery != nil, launch.links.reddit.media != nil,
         launch.links.reddit.campaign != nil, launch.links.reddit.launch != nil)
    }
    
    func showWikipediaPage() {
        if let link = launch.links.wikipedia {
            coordinator.openWebViewLink(with: link)
        }
    }
    
    func imageSelected(at index: Int) {
        coordinator.showFullscreenImage(with: launch.links.flickr.original![index])
    }
    
    func loadImageForCell(at index: Int, callback: @escaping (UIImage) -> Void) {
        service.imageCacher.loadImage(urlString: launch.links.flickr.original![index], completion: callback)
    }
    
    func loadTitleImage(callback: @escaping (UIImage) -> Void) {
        if let url = launch.links.patch.small {
            service.imageCacher.loadImage(urlString: url, completion: callback)
        }
       
    }
    var numberOfImages: Int {
        return launch.links.flickr.original?.count ?? 0
    }
    
    func showPage(_ content: LaunchMediaContent) {
        var link: String?
        switch content {
        
        case .wikipedia:
            link = launch.links.wikipedia
        case .youtube:
            link = launch.links.youtube
        case .campaign:
            link = launch.links.reddit.campaign
        case .media:
        link = launch.links.reddit.media
        case .recovery:
            link = launch.links.reddit.recovery
        case .launch:
            link = launch.links.reddit.launch
        }
        if let link = link {
            coordinator.openWebViewLink(with: link)
        }
    }
    
    init(service: ServiceType, model: Launch, coordinator: LaunchDetailsCoordinator) {
        self.service = service
        self.launch = model
        self.coordinator = coordinator
    }
    
    func onViewActive() {
        guard let rocketID = launch.rocket else {return}
        
        let completion: (Result<Rocket, Error>) -> Void = {[weak self]
            result in
            DispatchQueue.main.async {
                switch result {
                case let .success(rocket):
                    self?.rocket = rocket
                    self?.delegate?.reloadRocket()
                    
                case .failure(_):
                    print("There is an error")
                }
            }
        }
        
        DispatchQueue.global(qos: .utility).async {
            self.service.networkService.get(request: .rocket(id: rocketID), callback: completion)
        }
    }
    
}
