//
//  ImageCell.swift
//  RSTask11
//
//  Created by Ivan Budovich on 9/13/21.
//

import UIKit

class ImageCell: UICollectionViewCell {
    enum Constants{
        static let reuseIdentifier: String = "ImageID"
    }
    @IBOutlet var imageView: UIImageView!
    let layer1 = CALayer()
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        layer.shadowRadius = 1.5
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        layer.shadowColor = UIColor.smockyBlack.cgColor
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 3
        layer1.shadowColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layer1.cornerRadius = 10
        layer1.opacity = 1.0
        layer1.shadowRadius = 1.5
        layer1.shadowOffset = CGSize(width: -2, height: -1)
        layer.insertSublayer(layer1, at: 0)
        imageView.layer.cornerRadius = 7
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer1.frame = layer.bounds
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 9).cgPath
        layer1.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 9).cgPath
    }
}
