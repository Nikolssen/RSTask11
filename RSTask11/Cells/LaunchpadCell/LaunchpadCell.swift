//
//  LaunchpadCell.swift
//  RSTask11
//
//  Created by Ivan Budovich on 9/10/21.
//

import UIKit

class LaunchpadCell: UICollectionViewCell {
    
    enum Constants {
        static let widthToHeightRatio: CGFloat = 377.0 / 140.0
        static let reuseIdentifier: String = "LaunchpadCellID"
        static let nib: UINib = UINib(nibName: "LaunchpadCell", bundle: nil)
    }
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var shadowedView: ShadowedView!
    @IBOutlet var titleLabelTopAnchor: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        if UIDevice.isSEorTouch {
            titleLabelTopAnchor.constant = 10
            nameLabel.font = .robotoBold20
        }
        layer.shadowColor = UIColor.black.withAlphaComponent(0.37).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 1.0
        layer.cornerRadius = 15.0
        layer.masksToBounds = false
    }

    func configure(with viewData: LaunchpadCellViewData){
        nameLabel.text = viewData.name
        locationLabel.text = viewData.location
        shadowedView.style = .status(viewData.status)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        locationLabel.text = nil
    }
}
