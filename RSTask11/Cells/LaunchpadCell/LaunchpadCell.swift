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
    }
    
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var locationLabel: UILabel!
    @IBOutlet var shadowedView: ShadowedView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor.black.withAlphaComponent(0.37).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 1.0
        layer.cornerRadius = 15.0
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
