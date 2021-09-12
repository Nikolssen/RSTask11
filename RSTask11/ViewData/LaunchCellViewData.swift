//
//  LaunchCellViewData.swift
//  RSTask11
//
//  Created by Admin on 10.09.2021.
//

import Foundation
import UIKit

struct LaunchCellViewData {
    let name: String
    let date: String?
    let isPlanned: Bool
    let number: String
    let imageURL: String?
    let imageCacher: ImageCacherType
    
    func loadImage(for imageView: UIImageView){
        imageView.image = .defaultImage
        guard let imageURL = imageURL else {return}
        imageCacher.loadImage(urlString: imageURL){
            image in
            UIView.transition(with: imageView, duration: 0.4, options: .curveEaseInOut, animations: {
                imageView.image = image
            }, completion: nil)
        }
    }
}
