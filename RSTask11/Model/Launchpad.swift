//
//  Launchpad.swift
//  RSTask11
//
//  Created by Ivan Budovich on 9/10/21.
//

import Foundation

struct Launchpad {
    

    let images: [String]
    let name: String
    let fullName: String
    let region: String
    let latitude: Double
    let longitude: Double
    let locality: String
    let launchAttempts: Int
    let launchSuccesses: Int
    let rockets: [String]
    let launches: [String]
    let status: String
    let details: String
    let id: String
    
}

extension Launchpad: Decodable {
    
    enum ImagesCodingKeys: String, CodingKey {
            case large
        }
    
    enum CodingKeys: String, CodingKey {
        case images
        case name
        case fullName = "full_name"
        case locality
        case region
        case latitude
        case longitude
        case launchAttempts = "launch_attempts"
        case launchSuccesses = "launch_successes",
        rockets, launches, status, details, id
    }
    
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let imagesContainer = try container.nestedContainer(keyedBy: ImagesCodingKeys.self, forKey: .images)
        let images = try imagesContainer.decode([String].self, forKey: .large)
        
        let name = try container.decode(String.self, forKey: .name)
        let fullName = try container.decode(String.self, forKey: .fullName)
        let region = try container.decode(String.self, forKey: .region)
        let latitude = try container.decode(Double.self, forKey: .latitude)
        let longitude = try container.decode(Double.self, forKey: .longitude)
        let launchAttempts = try container.decode(Int.self, forKey: .launchAttempts)
        let launchSuccesses = try container.decode(Int.self, forKey: .launchSuccesses)
        let rockets = try container.decode([String].self, forKey: .rockets)
        let launches = try container.decode([String].self, forKey: .launches)
        let status = try container.decode(String.self, forKey: .status)
        let details = try container.decode(String.self, forKey: .details)
        let id = try container.decode(String.self, forKey: .id)
        let locality = try container.decode(String.self, forKey: .locality)
        self.init(images: images, name: name, fullName: fullName, region: region, latitude: latitude, longitude: longitude, locality: locality, launchAttempts: launchAttempts, launchSuccesses: launchSuccesses, rockets: rockets, launches: launches, status: status, details: details, id: id)
    }
}
extension Launchpad {
    enum SortingOptions {
        case title
        case region
        case status
    }
    enum FilterOptions {
        case active
        case retired
        case all
    }
}
