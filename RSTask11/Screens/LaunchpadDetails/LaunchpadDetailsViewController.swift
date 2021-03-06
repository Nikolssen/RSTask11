//
//  LaunchpadDetailsViewController.swift
//  RSTask11
//
//  Created by Admin on 12.09.2021.
//

import UIKit
import CoreLocation
import MapKit

class LaunchpadDetailsViewController: UIViewController {
    var presenter: LaunchpadDetailsPresenter!
    
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
    @IBOutlet var launchesButton: ShadowedButton!
    @IBOutlet var stackView: UIStackView!
    
    @IBOutlet var materialsStackView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = presenter.title
        fullNameLabel.text = presenter.fullName
        statusView.style = .status(presenter.status) 
        descriptionLabel.text = presenter.description
        regionLabel.text = presenter.region
        locationLabel.text = presenter.location
        launchAttemptsLabel.text = presenter.launchAttempts
        launchSuccessLabel.text = presenter.launchSuccess
        
        if presenter.numberOfImages > 0 {
            imagesCollectionView.delegate = self
            imagesCollectionView.dataSource = self
            imagesCollectionView.register(ImageCell.Constants.nib, forCellWithReuseIdentifier: ImageCell.Constants.reuseIdentifier)
        }
        else {
            imagesStackView.isHidden = true
        }
        
        if !presenter.areLaunchesAvaliable && !presenter.areRocketsAvailable {
            materialsStackView.isHidden = true
        }
        else {
            rocketButton.isHidden = !presenter.areRocketsAvailable
            launchesButton.isHidden = !presenter.areLaunchesAvaliable
        }
        
        navigationItem.title = presenter.title
        
        let annotation = MKPointAnnotation()
        let coordinates = presenter.coordinates
        annotation.coordinate = CLLocationCoordinate2D(latitude: coordinates.0, longitude: coordinates.1)
        annotation.title = presenter.fullName
        shadowedMapView.mapView.addAnnotation(annotation)
        shadowedMapView.mapView.setRegion(.init(center: annotation.coordinate, latitudinalMeters: 500000, longitudinalMeters: 500000), animated: false)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @IBAction func showRockets(_ sender: Any) {
        presenter.showRockets()
    }
    
    @IBAction func showLaunches(_ sender: Any) {
        presenter.showLaunches()
    }
}

extension LaunchpadDetailsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.imageSelected(at: indexPath.item)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        30
    }
}
