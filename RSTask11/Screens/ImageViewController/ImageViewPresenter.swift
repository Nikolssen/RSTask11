//
//  ImageViewPresenter.swift
//  RSTask11
//
//  Created by Ivan Budovich on 9/14/21.
//

import Foundation
import UIKit

protocol ImageViewPresenterType {
    func loadImage(handler: @escaping (UIImage) -> Void)
}

class ImageViewPresenter: ImageViewPresenterType {
    let service: ServiceType
    let url: String
    
    init(service: ServiceType, url: String) {
        self.service = service
        self.url = url
    }
    
    func loadImage(handler: @escaping (UIImage) -> Void) {
        service.imageCacher.loadImage(urlString: url, completion: handler)
    }
}
