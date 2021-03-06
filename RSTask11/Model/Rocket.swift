//
//  Rocket.swift
//  RSTask11
//
//  Created by Ivan Budovich on 10.09.2021.
//

import Foundation

struct Rocket {
    
    enum ThrustCodingKeys: String, CodingKey{
        case kN
    }
    
    struct FirstStage: Decodable {

        enum CodingKeys: String, CodingKey {
            case thrust_sea_level, thrust_vacuum, reusable, engines, fuel_amount_tons, burn_time_sec
        }
        let thrustSeaLevel: Int
        let thrustVacuum: Int
        let isReusable: Bool
        let engines: Int
        let fuel: Double
        let burnTime: Int?
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            let thrustSeaLevelContainer = try container.nestedContainer(keyedBy: ThrustCodingKeys.self, forKey: .thrust_sea_level)
            self.thrustSeaLevel = try thrustSeaLevelContainer.decode(Int.self, forKey: .kN)
            
            let thrustVacuumContainer = try container.nestedContainer(keyedBy: ThrustCodingKeys.self, forKey: .thrust_vacuum)
            self.thrustVacuum = try thrustVacuumContainer.decode(Int.self, forKey: .kN)
            
            self.isReusable = try container.decode(Bool.self, forKey: .reusable)
            self.engines = try container.decode(Int.self, forKey: .engines)
            self.fuel = try container.decode(Double.self, forKey: .fuel_amount_tons)
            self.burnTime = try? container.decode(Int.self, forKey: .burn_time_sec)
        }
        
        init(thrustSeaLevel: Int, thrustVacuum: Int, isReusable: Bool, engines: Int, fuel: Double, burnTime: Int?) {
            self.thrustSeaLevel = thrustSeaLevel
            self.thrustVacuum = thrustVacuum
            self.isReusable = isReusable
            self.engines = engines
            self.fuel = fuel
            self.burnTime = burnTime
        }
    }
    
    struct SecondStage: Decodable {
        init(thrust: Int, isReusable: Bool, engines: Int, fuel: Double, burnTime: Int?) {
            self.thrust = thrust
            self.isReusable = isReusable
            self.engines = engines
            self.fuel = fuel
            self.burnTime = burnTime
        }
        
        enum CodingKeys: String, CodingKey{
            case thrust, reusable, engines, fuel_amount_tons, burn_time_sec
        }
        let thrust: Int
        let isReusable: Bool
        let engines: Int
        let fuel: Double
        let burnTime: Int?
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            let thrustContainer = try container.nestedContainer(keyedBy: ThrustCodingKeys.self, forKey: .thrust)
            self.thrust = try thrustContainer.decode(Int.self, forKey: .kN)
            
            self.isReusable = try container.decode(Bool.self, forKey: .reusable)
            self.engines = try container.decode(Int.self, forKey: .engines)
            self.fuel = try container.decode(Double.self, forKey: .fuel_amount_tons)
            self.burnTime = try? container.decode(Int.self, forKey: .burn_time_sec)
        }
    }
    
    struct Engine: Decodable {
        
        enum CodingKeys: String, CodingKey {
            case type, layout, version, propellant_1, propellant_2, number
        }
        
        let type: String
        let layout: String?
        let number: Int
        let version: String
        let propellant1: String
        let propellant2: String
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.layout = try? container.decode(String.self, forKey: .layout)
            self.number = try container.decode(Int.self, forKey: .number)
            self.type = try container.decode(String.self, forKey: .type)
            self.version = try container.decode(String.self, forKey: .version)
            self.propellant1 = try container.decode(String.self, forKey: .propellant_1)
            self.propellant2 = try container.decode(String.self, forKey: .propellant_2)
        }
        
        init(type: String, layout: String?, number: Int, version: String, propellant1: String, propellant2: String) {
            self.type = type
            self.layout = layout
            self.number = number
            self.version = version
            self.propellant1 = propellant1
            self.propellant2 = propellant2
        }
    }
    
    struct LandingLegs: Decodable {
        let material: String
        let number: Int
    }
    
    let name: String
    let height: Double
    let diameter: Double
    let mass: Int
    
    let firstStage: FirstStage
    let secondStage: SecondStage
    let engine: Engine
    let landingLegs: LandingLegs?
    let isActive: Bool
    let successRate: Int
    let firstLaunch: String
    let launchCost: Int
    let images: [String]
    let wikipediaLink: String
    let id: String
    let description: String
    
}

extension Rocket: Decodable {
    enum CodingKeys: String, CodingKey{
        case height, diameter, mass
        case firstStage = "first_stage", secondStage = "second_stage", engines
        case landingLegs = "landing_legs", flickrImages = "flickr_images", name, active
        case costPerLaunch = "cost_per_launch", successRate = "success_rate_pct", firstFlight = "first_flight", wikipedia, description, id
    }
    
    enum HeightCodingKeys: String, CodingKey{
        case meters
        case feet
    }
    enum MassCodingKeys: String, CodingKey{
        case kg
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        
        let heightContainer = try container.nestedContainer(keyedBy: HeightCodingKeys.self, forKey: .height)
        self.height = try heightContainer.decode(Double.self, forKey: .meters)
        
        let diameterContainer = try container.nestedContainer(keyedBy: HeightCodingKeys.self, forKey: .diameter)
        self.diameter = try diameterContainer.decode(Double.self, forKey: .meters)
        
        let massContainer = try container.nestedContainer(keyedBy: MassCodingKeys.self, forKey: .mass)
        self.mass = try massContainer.decode(Int.self, forKey: .kg)
        
        self.description = try container.decode(String.self, forKey: .description)
        self.successRate = try container.decode(Int.self, forKey: .successRate)
        self.firstStage = try container.decode(FirstStage.self, forKey: .firstStage)
        self.secondStage = try container.decode(SecondStage.self, forKey: .secondStage)
        self.firstLaunch = try container.decode(String.self, forKey: .firstFlight)
        self.landingLegs = try? container.decode(LandingLegs.self, forKey: .landingLegs)
        self.isActive = try container.decode(Bool.self, forKey: .active)
        self.engine = try container.decode(Engine.self, forKey: .engines)
        self.id = try container.decode(String.self, forKey: .id)
        self.images = try container.decode([String].self, forKey: .flickrImages)
        self.wikipediaLink = try container.decode(String.self, forKey: .wikipedia)
        self.launchCost = try container.decode(Int.self, forKey: .costPerLaunch)
    }
}

extension Rocket {
    enum SortingOptions{
        case firstLaunch
        case launchCost
        case success
    }
}
