//
//  RocketCellViewData.swift
//  RSTask11
//
//  Created by Admin on 10.09.2021.
//

import Foundation
import UIKit

struct RocketCellViewData {
    let name: String
    let firstLaunch: String
    let cost: String
    let success: String
    let imageURL: String?
    let imageCacher: ImageCacherType
    
    func loadImage(for imageView: UIImageView){
        imageView.image = .defaultImage
        guard let imageURL = imageURL else {return}
        imageCacher.loadImage(urlString: imageURL){
            image in
            imageView.image = image
        }
    }
}
