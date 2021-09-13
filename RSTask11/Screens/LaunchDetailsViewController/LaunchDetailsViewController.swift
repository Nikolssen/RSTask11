//
//  LaunchDetailsViewController.swift
//  RSTask11
//
//  Created by Admin on 12.09.2021.
//

import UIKit

class LaunchDetailsViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var indicatorView: IndicatorView!
    @IBOutlet var shadowedView: ShadowedView!
    @IBOutlet var shadowedImageView: ShadowedImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var successLabel: UILabel!
    @IBOutlet var staticFireDateLabel: UILabel!
    @IBOutlet var launchDateLabel: UILabel!
    
    @IBOutlet var imagesStackView: UIStackView!
    @IBOutlet var imagesCollectionView: UICollectionView!
    @IBOutlet var rocketStackView: UIStackView!
    @IBOutlet var rocketCollectionView: UICollectionView!
    @IBOutlet var materialsStackView: UIStackView!
    @IBOutlet var redditStackView: UIStackView!
    @IBOutlet var wikipediaButton: ShadowedButton!
    @IBOutlet var youtubeButton: ShadowedButton!
    @IBOutlet var recoveryButton: ShadowedButton!
    @IBOutlet var mediaButton: ShadowedButton!
    @IBOutlet var compaignButton: ShadowedButton!
    @IBOutlet var launchButton: ShadowedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}
