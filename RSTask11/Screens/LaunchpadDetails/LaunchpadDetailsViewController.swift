//
//  LaunchpadDetailsViewController.swift
//  RSTask11
//
//  Created by Admin on 12.09.2021.
//

import UIKit

class LaunchpadDetailsViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var fullNameLabel: UILabel!
    @IBOutlet var statusView: ShadowedView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var regionLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var launchAttemptsLabel: UILabel!
    @IBOutlet var launchSuccessLabel: UILabel!
    
    @IBOutlet var imagesStackView: UIStackView!
    @IBOutlet var imagesCollectionView: UICollectionView!
    @IBOutlet var shadowedMapView: ShadowedMapView!
    @IBOutlet var rocketButton: ShadowedButton!
    @IBOutlet var launchesLabel: ShadowedButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
