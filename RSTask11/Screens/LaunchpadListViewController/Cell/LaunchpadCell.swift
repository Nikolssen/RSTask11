//
//  LaunchpadCell.swift
//  RSTask11
//
//  Created by Ivan Budovich on 9/10/21.
//

import UIKit

class LaunchpadCell: UICollectionViewCell {
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var locationLabel: UILabel!
    @IBOutlet var shadowedView: ShadowedView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
