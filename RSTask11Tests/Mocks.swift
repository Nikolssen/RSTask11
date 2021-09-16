//
//  Mocks.swift
//  RSTask11Tests
//
//  Created by Ivan Budovich on 9/16/21.
//

import Foundation
import UIKit

@testable import RSTask11

class DetailsCoordinatorMock: DetailsCoordinator {
    var didShowFullScreenImage: Bool = false
    var didOpenWebLink: Bool = false
    
    func showFullscreenImage(with url: String) {
        didShowFullScreenImage = true
    }
    
    func openWebViewLink(with url: String) {
        didOpenWebLink = true
    }
}

class LaunchpadDetailsCoordinatorMock: LaunchpadDetailsCoordinator {
    var didShowFullScreenImage: Bool = false
    var didOpenWebLink: Bool = false
    var didShowRockets: Bool = false
    var didShowLaunches: Bool = false
    
    func showRockets(with ids: [String]) {
        didShowRockets = true
    }
    
    func showLaunches(with ids: [String]) {
        didShowLaunches = true
    }
    
    func showFullscreenImage(with url: String) {
        didShowFullScreenImage = true
    }
    
    func openWebViewLink(with url: String) {
        didOpenWebLink = true
    }
    
    
}

class LaunchDetailsCoordinatorMock: LaunchDetailsCoordinator{
    var didShowFullScreenImage: Bool = false
    var didOpenWebLink: Bool = false
    var didShowRocket: Bool = false
    
    func showRocket(model: Rocket) {
        didShowRocket = true
    }
    
    func showFullscreenImage(with url: String) {
        didShowFullScreenImage = true
    }
    
    func openWebViewLink(with url: String) {
        didOpenWebLink = true
    }
    
}

class LaunchListCoordinatorMock: LaunchListPresenterCoordinator{
    var didShowDetails: Bool = false
    func showDetails(model: Launch) {
        didShowDetails = true
    }
    
}
class LaunchpadListCoordinatorMock: LaunchListPresenterCoordinator {
    var didShowDetails: Bool = false
    
    func showDetails(model: Launch) {
        didShowDetails = true
    }
}

class ServiceMock: ServiceType {
    internal init(networkService: NetworkServiceType, imageCacher: ImageCacherType) {
        self.networkService = networkService
        self.imageCacher = imageCacher
    }
    
    var networkService: NetworkServiceType
    
    var imageCacher: ImageCacherType
    
    
}

class NetworkServiceMock : NetworkServiceType {
    func get<T>(request: Request, callback: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        
    }
}

class ImageCacherMock : ImageCacherType {
    func loadImage(urlString: String, completion: @escaping (UIImage) -> Void) {
        
    }
}
