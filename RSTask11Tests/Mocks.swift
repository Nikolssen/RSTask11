//
//  Mocks.swift
//  RSTask11Tests
//
//  Created by Ivan Budovich on 9/16/21.
//

import Foundation
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
