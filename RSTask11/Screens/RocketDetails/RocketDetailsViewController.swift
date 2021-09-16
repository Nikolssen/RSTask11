//
//  RocketDetailsViewController.swift
//  RSTask11
//
//  Created by Admin on 12.09.2021.
//

import UIKit

class RocketDetailsViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var backButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var firstLaunchLabel: UILabel!
    @IBOutlet var launchCostLabel: UILabel!
    @IBOutlet var successRateLabel: UILabel!
    @IBOutlet var massLabel: UILabel!
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var diameterLabel: UILabel!
    @IBOutlet var imageStackView: UIStackView!
    @IBOutlet var imageCollectionView: UICollectionView!
    @IBOutlet var firstStageReusableLabel: UILabel!
    @IBOutlet var firstStageEnginesAmountLabel: UILabel!
    @IBOutlet var firstStageFuelAmountLabel: UILabel!
    @IBOutlet var firstStageBurningTimeLabel: UILabel!
    @IBOutlet var firstStageBurningTimeMarker: UILabel!
    @IBOutlet var seaLevelThrustLabel: UILabel!
    @IBOutlet var vacuumThrustLabel: UILabel!
    
    @IBOutlet var secondStageReusableLabel: UILabel!
    
    @IBOutlet var secondStageEnginesAmountLabel: UILabel!
    @IBOutlet var secondStageFuelAmouneLabel: UILabel!
    @IBOutlet var secondStageBurningTimeLabel: UILabel!
    @IBOutlet var secondStageBurningTimeMarker: UILabel!
    @IBOutlet var thrustLabel: UILabel!
    @IBOutlet var landingLegsStackView: UIStackView!
    @IBOutlet var landingLegsAmountLabel: UILabel!
    @IBOutlet var landingLegsMaterialLabel: UILabel!
    
    @IBOutlet var engineTypeLabel: UILabel!
    @IBOutlet var engineLayoutLabel: UILabel!
    @IBOutlet var engineLayoutMarker: UILabel!
    @IBOutlet var engineVersionLabel: UILabel!
    @IBOutlet var engineAmountLabel: UILabel!
    @IBOutlet var enginePropellant1Label: UILabel!
    @IBOutlet var enginePropellant2Label: UILabel!
    
    @IBOutlet var imageViewTopConstaint: NSLayoutConstraint!
    @IBOutlet var scrollViewTopConstraint: NSLayoutConstraint!
    @IBOutlet var backButtonTopConstraint: NSLayoutConstraint!
    
    let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.51, 1]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 01)
        return gradientLayer
    }()
    var presenter: RocketDetailsPresenterType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = presenter.title
        descriptionLabel.text = presenter.description
        firstLaunchLabel.text = presenter.firstLaunch
        launchCostLabel.text = presenter.launchCost
        successRateLabel.text = presenter.successRate
        massLabel.text = presenter.mass
        heightLabel.text = presenter.height
        diameterLabel.text = presenter.diameter
        
        if presenter.firstStageBurningTime == nil {
            firstStageBurningTimeMarker.isHidden = true
            firstStageBurningTimeLabel.isHidden = true
        }
        else {
            firstStageBurningTimeLabel.text = presenter.firstStageBurningTime
        }
        
        firstStageReusableLabel.text = presenter.firstStageReusable
        firstStageFuelAmountLabel.text = presenter.firstStageFuelAmount
        vacuumThrustLabel.text = presenter.firstStageVacuumThrust
        seaLevelThrustLabel.text = presenter.firstStageSeaLevelThrust
        firstStageEnginesAmountLabel.text = presenter.firstStageEnginesAmount
        
        if presenter.secondStageBurningTime == nil {
            secondStageBurningTimeMarker.isHidden = true
            secondStageBurningTimeLabel.isHidden = true
        }
        else {
            secondStageBurningTimeLabel.text = presenter.secondStageBurningTime
        }
        
        secondStageReusableLabel.text = presenter.secondStageReusable
        secondStageFuelAmouneLabel.text = presenter.secondStageFuelAmount
        thrustLabel.text = presenter.secondStageThrust
        secondStageEnginesAmountLabel.text = presenter.secondStageEnginesAmount
        
        if presenter.engineLayout == nil {
            engineLayoutLabel.isHidden = true
            engineLayoutMarker.isHidden = true
        }
        else {
            engineLayoutLabel.text = presenter.engineLayout
        }
        
        engineTypeLabel.text = presenter.engineType
        engineAmountLabel.text = presenter.engineAmount
        engineVersionLabel.text = presenter.engineVersion
        enginePropellant1Label.text = presenter.enginePropellant1
        enginePropellant2Label.text = presenter.enginePropellant2
        
        if let landingLegs = presenter.langingLegs {
            landingLegsAmountLabel.text = landingLegs.0
            landingLegsMaterialLabel.text = landingLegs.1
        }
        else {
            landingLegsStackView.isHidden = true
        }
        
        presenter.loadTitleImage{
            [imageView] image in
            guard let imageView = imageView else { return }
            UIView.transition(with: imageView, duration: 0.4, options: .curveEaseInOut, animations: {
                imageView.image = image
            }, completion: nil)
        }
        
        imageView.layer.addSublayer(gradientLayer)
        if presenter.numberOfImages > 0 {
            imageCollectionView.delegate = self
            imageCollectionView.dataSource = self
            imageCollectionView.register(ImageCell.Constants.nib, forCellWithReuseIdentifier: ImageCell.Constants.reuseIdentifier)
        }
        else {
            imageStackView.isHidden = true
        }
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        scrollViewTopConstraint.constant = -statusBarHeight
        imageViewTopConstaint.constant = -statusBarHeight
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = imageView.layer.bounds
    }
    @IBAction func showWikipedia(_ sender: Any) {
        presenter.showWikipediaPage()
    }
    
    @IBAction func goBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension RocketDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfImages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.Constants.reuseIdentifier, for: indexPath) as? ImageCell else { return UICollectionViewCell() }
        presenter.loadImageForCell(at: indexPath.item) {
            cell.imageView.image = $0
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 145, height: 195)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.imageSelected(at: indexPath.item)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        30
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
}
