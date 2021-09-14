import Foundation
struct Launch: Decodable {
    
    struct Patch: Decodable {
        var small: String?
        var large: String?
    }
    struct Reddit: Decodable {
        var campaign: String?
        var launch: String?
        var media: String?
        var recovery: String?
    }
    struct Flickr: Decodable {
        var small: [String]?
        var original: [String]?
    }

    struct Links: Decodable {
        enum CodingKeys: String, CodingKey {
            case patch
            case reddit
            case flickr
            case youtube = "webcast"
            case wikipedia
        }
        
        var patch: Patch
        var reddit: Reddit
        var flickr: Flickr
        var youtube: String?
        var wikipedia: String?
    }
    
    enum CodingKeys: String, CodingKey {
        case links
        case name
        case success
        case details
        case flightNumber = "flight_number"
        case launchDate = "date_utc"
        case upcoming
        case staticFireDate = "static_fire_date_utc"
        case rocket
    }
    let links: Links
    
    // Header
    let name: String
    let success: Bool?
    let upcoming: Bool
    let flightNumber: Int
    let details: String?
    let staticFireDate: String?
    let launchDate: String?
    let rocket: String?
}
