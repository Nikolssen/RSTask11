//
//  RocketDetailsTest.swift
//  RSTask11Tests
//
//  Created by Ivan Budovich on 9/16/21.
//

import XCTest
@testable import RSTask11

class RocketDetailsTest: XCTestCase {

    var presenter: RocketDetailsPresenter!
    var coordinator: DetailsCoordinatorMock = DetailsCoordinatorMock()
    var imageCacher: ImageCacherType = ImageCacherMock()
    
    override func setUp() {
            presenter = RocketDetailsPresenter(service: ServiceMock(networkService: NetworkServiceMock(), imageCacher: ImageCacherMock()), model: RocketDetailsTest.fullRocket, coordinator: coordinator)
    }

    func testProperties() {
        let presenter2 = RocketDetailsPresenter(service: ServiceMock(networkService: NetworkServiceMock(), imageCacher: ImageCacherMock()), model: RocketDetailsTest.partlyFullRocket, coordinator: coordinator)
        
        //Description
        XCTAssertEqual(presenter.title, presenter.rocket.name)
        XCTAssertEqual(presenter2.title, presenter2.rocket.name)
        
        //Description
        XCTAssertEqual(presenter.description, presenter.rocket.description)
        XCTAssertEqual(presenter2.description, presenter2.rocket.description)
        
        //First Launch
        XCTAssertEqual(presenter.firstLaunch, "February 6, 2018")
        XCTAssertEqual(presenter2.firstLaunch, "20180206")
        
        XCTAssertEqual(presenter.launchCost, "200000$")
        XCTAssertEqual(presenter2.launchCost, "456$")
        
        XCTAssertEqual(presenter.successRate, "40%")
        XCTAssertEqual(presenter2.successRate, "0%")
        
        XCTAssertEqual(presenter.mass, "5000 kg")
        XCTAssertEqual(presenter2.mass, "250 kg")
        
        XCTAssertEqual(presenter.height, "20.0 meters")
        XCTAssertEqual(presenter2.height, "10.0 meters")
        
        XCTAssertEqual(presenter.diameter, "30.0 meters")
        XCTAssertEqual(presenter2.diameter, "40.0 meters")
        
        XCTAssertEqual(presenter.numberOfImages, 1)
        XCTAssertEqual(presenter2.numberOfImages, 0)
        
        XCTAssertEqual(presenter.engineType,  presenter.rocket.engine.type)
        XCTAssertEqual(presenter2.engineType, presenter2.rocket.engine.type)
        
        XCTAssertEqual(presenter.engineLayout, presenter.rocket.engine.layout)
        XCTAssertEqual(presenter2.engineLayout, presenter2.rocket.engine.layout)
        
        XCTAssertEqual(presenter.engineVersion, presenter.rocket.engine.version)
        XCTAssertEqual(presenter2.engineVersion, presenter2.rocket.engine.version)
        
        XCTAssertEqual(presenter.engineAmount, "4")
        XCTAssertEqual(presenter2.engineAmount, "0")
        
        XCTAssertEqual(presenter.enginePropellant1, "Prop")
        XCTAssertEqual(presenter2.enginePropellant1, "Pr")
        
        XCTAssertEqual(presenter.enginePropellant2, "Prop2")
        XCTAssertEqual(presenter2.enginePropellant2, "Pr2")
        
        XCTAssertEqual(presenter.firstStageReusable,  "Yes")
        XCTAssertEqual(presenter2.firstStageReusable, "No")
        
        XCTAssertEqual(presenter.firstStageEnginesAmount, "2")
        XCTAssertEqual(presenter2.firstStageEnginesAmount, "2")
        
        XCTAssertEqual(presenter.firstStageFuelAmount, "45555.0 tons")
        XCTAssertEqual(presenter2.firstStageFuelAmount, "500.0 tons")
        
        XCTAssertEqual(presenter.firstStageBurningTime, "450 seconds")
        XCTAssertNil(presenter2.firstStageBurningTime)
        
        XCTAssertEqual(presenter.firstStageVacuumThrust, "340 kN")
        XCTAssertEqual(presenter2.firstStageVacuumThrust, "10 kN")
        
        XCTAssertEqual(presenter.firstStageSeaLevelThrust, "560 kN")
        XCTAssertEqual(presenter2.firstStageSeaLevelThrust, "45 kN")
        
        XCTAssertEqual(presenter.secondStageReusable,  "No")
        XCTAssertEqual(presenter2.secondStageReusable, "No")
        
        XCTAssertEqual(presenter.secondStageEnginesAmount, "2")
        XCTAssertEqual(presenter2.secondStageEnginesAmount, "1")
        
        XCTAssertEqual(presenter.secondStageFuelAmount, "23.0 tons")
        XCTAssertEqual(presenter2.secondStageFuelAmount, "700.0 tons")
        
        XCTAssertEqual(presenter.secondStageBurningTime, "500 seconds")
        XCTAssertNil(presenter2.secondStageBurningTime)
        
        XCTAssertEqual(presenter.secondStageThrust, "20 kN")
        XCTAssertEqual(presenter2.secondStageThrust, "50 kN")
        
        XCTAssertEqual(presenter.langingLegs?.0, "2")
        XCTAssertEqual(presenter.langingLegs?.1, "Steel")
        XCTAssertNil(presenter2.langingLegs)
    
    }
    
    func testWikipedia() throws {
        presenter.showWikipediaPage()
        XCTAssertTrue(self.coordinator.didOpenWebLink)
    }
    
    

    static let fullRocket: Rocket = Rocket(name: "Rocket", height: 20.0, diameter: 30.0, mass: 5000, firstStage: Rocket.FirstStage(thrustSeaLevel: 560, thrustVacuum: 340, isReusable: true, engines: 2, fuel: 45555, burnTime: 450), secondStage: Rocket.SecondStage(thrust: 20, isReusable: false, engines: 2, fuel: 23, burnTime: 500), engine: Rocket.Engine(type: "Any", layout: "Auto", number: 4, version: "Beta", propellant1: "Prop", propellant2: "Prop2"), landingLegs: Rocket.LandingLegs(material: "Steel", number: 2), isActive: true, successRate: 40, firstLaunch: "2018-02-06", launchCost: 200000, images: ["https://farm5.staticflickr.com/4599/38583829295_581f34dd84_b.jpg"], wikipediaLink: "https://en.wikipedia.org/wiki/Falcon_Heavy", id: "0xFF", description: "The description")
    
    static let partlyFullRocket: Rocket = Rocket(name: "Spaceship", height: 10, diameter: 40, mass: 250, firstStage: Rocket.FirstStage(thrustSeaLevel: 45, thrustVacuum: 10, isReusable: false, engines: 2, fuel: 500, burnTime: nil), secondStage: Rocket.SecondStage(thrust: 50, isReusable: false, engines: 1, fuel: 700, burnTime: nil), engine: Rocket.Engine(type: "Any", layout: "Auto", number: 0, version: "0", propellant1: "Pr", propellant2: "Pr2"), landingLegs: nil, isActive: false, successRate: 0, firstLaunch: "20180206", launchCost: 456, images: [], wikipediaLink: "https://en.wikipedia.org/wiki/Falcon_Heavy", id: "0x00", description: "The description")
}

