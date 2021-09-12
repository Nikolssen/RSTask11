//
//  LaunchCell.swift
//  RSTask11
//
//  Created by Ivan Budovich on 9/9/21.
//

import UIKit

class LaunchCell: UICollectionViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var indicatorView: IndicatorView!
    @IBOutlet var shadowedView: ShadowedView!
    @IBOutlet var shadowedImageView: ShadowedImageView!
    
    enum Constants{
        static let widthToHeightRatio: CGFloat = 377.0 / 145.0
        static let reuseIdentifier: String = "LaunchCellID"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor.black.withAlphaComponent(0.37).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 1.0
        layer.cornerRadius = 15.0
    }
    
    func configure(with viewData: LaunchCellViewData) {
        titleLabel.text = viewData.name
        dateLabel.text = viewData.date
        indicatorView.style = viewData.isPlanned ? .clock : .checkmark
        shadowedView.style = .number(viewData.number)
        viewData.loadImage(for: shadowedImageView.imageView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

}
