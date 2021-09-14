//
//  LaunchpadDetailsPresenter.swift
//  RSTask11
//
//  Created by Ivan Budovich on 9/14/21.
//

import Foundation
import UIKit

protocol LaunchpadDetailsPresenterType {
    var title: String {get}
    var fullNAme: String {get}
    var status: String {get}
    var description: String {get}
    var region: String {get}
    var location: String {get}
    var launchAtterpts: String {get}
    var launchSuccess: String {get}
    
    var numberOfImages: String {get}
    var coordinates: (Double, Double) {get}
    
    var areRocketsAvailable: Bool {get}
    var areLaunchesAvaliable: Bool {get}
    
    func loadImageForCell(at index: Int, callback: @escaping (UIImage) -> Void)
}

class LaunchpadDetailsPresenter: LaunchpadDetailsPresenterType{
    var title: String
    
    var fullNAme: String
    
    var status: String
    
    var description: String
    
    var region: String
    
    var location: String
    
    var launchAtterpts: String
    
    var launchSuccess: String
    
    var numberOfImages: String
    
    var coordinates: (Double, Double)
    
    var areRocketsAvailable: Bool
    
    var areLaunchesAvaliable: Bool
    
    func loadImageForCell(at index: Int, callback: @escaping (UIImage) -> Void) {
        <#code#>
    }
    
    
}
