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
        static let nib: UINib = UINib(nibName: "ImageCell", bundle: nil)
    }
    @IBOutlet var imageView: UIImageView!
    let layer1 = CALayer()
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        layer.shadowRadius = 1.5
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        layer.shadowColor = UIColor.shadow.cgColor
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 3
        layer.masksToBounds = false
        layer1.shadowColor = UIColor.white.cgColor
        layer1.cornerRadius = 10
        layer1.opacity = 1.0
        layer1.shadowRadius = 1.5
        layer1.masksToBounds = false
        layer1.needsDisplayOnBoundsChange = true
        layer1.shadowOffset = CGSize(width: -2, height: -1)
        layer.insertSublayer(layer1, at: 1)
        imageView.layer.cornerRadius = 7
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer1.frame = layer.bounds
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 9).cgPath
        layer1.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 9).cgPath
    }
}
