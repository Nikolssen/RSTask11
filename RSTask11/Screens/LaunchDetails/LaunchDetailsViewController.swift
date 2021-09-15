//
//  LaunchDetailsViewController.swift
//  RSTask11
//
//  Created by Admin on 12.09.2021.
//

import UIKit

class LaunchDetailsViewController: UIViewController {
    
    var presenter: LaunchDetailsPresenterType!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var indicatorView: IndicatorView!
    @IBOutlet var shadowedView: ShadowedView!
    @IBOutlet var shadowedImageView: ShadowedImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var successLabel: UILabel!
    @IBOutlet var staticFireDateLabel: UILabel!
    @IBOutlet var launchDateLabel: UILabel!
    @IBOutlet var staticFireDateMarker: UILabel!
    @IBOutlet var launchDateMarker: UILabel!
    @IBOutlet var successMarker: UILabel!
    
    @IBOutlet var overviewStackView: UIStackView!
    @IBOutlet var descriptionStackView: UIStackView!
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

    @IBOutlet var campaignButton: ShadowedButton!
    @IBOutlet var launchButton: ShadowedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = presenter.title
        dateLabel.text = presenter.launchDate
        indicatorView.style = presenter.isPlanned ? .clock : .checkmark
        shadowedView.style = .number(presenter.number)
        
        presenter.loadTitleImage {
            [shadowedImageView] image in
            guard let shadowedImageView = shadowedImageView else { return }
            UIView.transition(with: shadowedImageView, duration: 0.4, options: .curveEaseInOut, animations: {
                shadowedImageView.imageView.image = image
            }, completion: nil)
        }
        
        if let description = presenter.description {
            descriptionLabel.text = description
        }
        else {
            descriptionStackView.isHidden = true
        }
        
        if presenter.staticFireDate == nil && presenter.launchDate == nil && presenter.success == nil {
            overviewStackView.isHidden = true
        }
        else {
            if let staticFireDate = presenter.staticFireDate {
                staticFireDateLabel.text = staticFireDate
            }
            else {
                staticFireDateLabel.isHidden = true
                staticFireDateMarker.isHidden = true
            }
            
            if let launchDate = presenter.launchDate {
                launchDateLabel.text = launchDate
            }
            else {
                launchDateLabel.isHidden = true
                launchDateMarker.isHidden = true
            }
            
            if let success = presenter.success {
                successLabel.text = success
            }
            else {
                successLabel.isHidden = true
                successMarker.isHidden = true
            }
        }
        
        if presenter.numberOfImages > 0 {
            imagesCollectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: ImageCell.Constants.reuseIdentifier)
            imagesCollectionView.delegate = self
            imagesCollectionView.dataSource = self
        }
        else {
            imagesStackView.isHidden = true
        }
        
        if presenter.hasRocket {
            rocketCollectionView.delegate = self
            rocketCollectionView.dataSource = self
            rocketCollectionView.register(UINib(nibName: "RocketCell", bundle: nil), forCellWithReuseIdentifier: RocketCell.Constants.reuseIdentifier)
        }
        else {
            rocketStackView.isHidden = true
        }
        
        let materials = presenter.hasWikipediaAndYoutube
        if !materials.0 && !materials.1 {
            materialsStackView.isHidden = true
        }
        else {
            wikipediaButton.isHidden = !materials.0
            youtubeButton.isHidden = !materials.1
        }
        
        let reddit = presenter.hasRedditLinks
        if !reddit.0 && !reddit.1 && !reddit.2 && reddit.3 {
            redditStackView.isHidden = false
        }
        else {
            recoveryButton.isHidden = !reddit.0
            mediaButton.isHidden = !reddit.1
            
            launchButton.isHidden = !reddit.3
        }
        navigationItem.title = presenter.title
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.onViewActive()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @IBAction func openLink(_ sender: UIButton) {
        if sender === wikipediaButton {
            presenter.showPage(.wikipedia)
            return
        }
        
        if sender === youtubeButton {
            presenter.showPage(.youtube)
            return
        }
        
        if sender === mediaButton {
            presenter.showPage(.media)
            return
        }
        if sender === campaignButton {
            presenter.showPage(.campaign)
            return
        }
        
        if sender === launchButton {
            presenter.showPage(.launch)
            return
        }
        
        if sender === recoveryButton {
            presenter.showPage(.recovery)
        }
    }
    
}


extension LaunchDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView === imagesCollectionView {
            return presenter.numberOfImages
        }
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView === imagesCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.Constants.reuseIdentifier, for: indexPath) as? ImageCell else { return UICollectionViewCell() }
            presenter.loadImageForCell(at: indexPath.item) {
                cell.imageView.image = $0
            }
            return cell
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RocketCell.Constants.reuseIdentifier, for: indexPath) as? RocketCell, let viewData = presenter.rocketViewData else {
            return UICollectionViewCell()
        }
        cell.configure(with: viewData)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView === imagesCollectionView {
            return CGSize(width: 145, height: 195)
        }
        let width = view.safeAreaLayoutGuide.layoutFrame.width - 40
        return CGSize(width: width, height: width / RocketCell.Constants.widthToHeightRatio)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView === imagesCollectionView {
            presenter.imageSelected(at: indexPath.item)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        30
    }
}

extension LaunchDetailsViewController: LaunchDetailsPresenterDelegate {
    func reloadRocket() {
        rocketCollectionView?.reloadData()
    }
}
