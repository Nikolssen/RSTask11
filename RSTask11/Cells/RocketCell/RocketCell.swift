//
//  RocketCell.swift
//  RSTask11
//
//  Created by Ivan Budovich on 9/9/21.
//

import UIKit

class RocketCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var firstLaunchLabel: UILabel!
    @IBOutlet var launchCostLabel: UILabel!
    @IBOutlet var successRateLabel: UILabel!
    @IBOutlet var stackView: UIStackView!
    
    let imageViewMask = CAShapeLayer()
    
    enum Constants {
        static let widthToHeightRatio: CGFloat = 377.0 / 360
        static let reuseIdentifier: String = "RocketCellID"
        static let nib: UINib = UINib(nibName: "RocketCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor.black.withAlphaComponent(0.37).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 1.0
        layer.cornerRadius = 15.0
        imageViewMask.path = UIBezierPath(roundedRect: imageView.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 15, height: 15)).cgPath
        imageView.layer.mask = imageViewMask
        layer.masksToBounds = false
    }
    
    func configure(with viewData: RocketCellViewData) {
        titleLabel.text = viewData.name
        firstLaunchLabel.text = viewData.firstLaunch
        launchCostLabel.text = viewData.cost
        successRateLabel.text = viewData.success
        viewData.loadImage(for: imageView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stackView.isHidden = false
    }
 
    override func layoutSubviews() {
        super.layoutSubviews()
        imageViewMask.path = UIBezierPath(roundedRect: imageView.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 15, height: 15)).cgPath
    }
}
