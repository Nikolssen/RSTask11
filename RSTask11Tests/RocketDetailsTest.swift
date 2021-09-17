//
//  RocketDetailsTest.swift
//  RSTask11Tests
//
//  Created by Ivan Budovich on 9/16/21.
//

import XCTest
@testable import RSTask11

class RocketDetailsTest: XCTestCase {

    var presenter: RocketDetailsPresenter?
    var coordinator: DetailsCoordinatorMock = DetailsCoordinatorMock()
    var imageCacher: ImageCacherType = ImageCacherMock()
    
    override func setUp() {
        presenter = RocketDetailsPresenter(service: ServiceMock(networkService: NetworkServiceMock(), imageCacher: ImageCacherMock()), model: RocketTest.rocket, coordinator: coordinator)
    }

    func testWikipedia() throws {
        guard let presenter = presenter else {
            return
        }
        presenter.showWikipediaPage()
        XCTAssertTrue(self.coordinator.didOpenWebLink)
        
    }
    
    

}
