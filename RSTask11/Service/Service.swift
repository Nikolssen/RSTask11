//
//  Service.swift
//  RSTask11
//
//  Created by Ivan Budovich on 9/10/21.
//

import Foundation

class Service: ServiceType {
    let networkService: NetworkServiceType = NetworkService()
}

protocol ServiceType {
    var networkService: NetworkServiceType {get}
}
