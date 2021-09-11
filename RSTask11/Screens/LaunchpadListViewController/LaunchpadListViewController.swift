//
//  LaunchpadListViewController.swift
//  RSTask11
//
//  Created by Ivan Budovich on 9/10/21.
//

import UIKit

final class LaunchpadListViewController: UICollectionViewController {

    var presenter: LaunchpadListPresenterType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .queenBlue
        collectionView.backgroundColor = .queenBlue
        self.collectionView.register(UINib(nibName: "LaunchpadCell", bundle: nil), forCellWithReuseIdentifier: LaunchpadCell.Constants.reuseIdentifier)
        configureNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillBecomeActive()
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.reloadData()
    }
    
    func configureNavigationBar(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: .bidirectionalArrow, style: .plain, target: self, action: #selector(showSortOptions))
        let segmentedControl = UISegmentedControl()
        segmentedControl.setTitleTextAttributes([.font: UIFont.robotoMedium13, .foregroundColor: UIColor.smockyBlack], for: .normal)
        segmentedControl.backgroundColor = .glaucous
        segmentedControl.insertSegment(withTitle: "All", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Active", at: 1, animated: false)
        segmentedControl.insertSegment(withTitle: "Retired", at: 2, animated: false)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(filter(sender:)), for: .valueChanged)
        self.navigationItem.titleView = segmentedControl
    }
    @objc func showSortOptions(){
        
    }
    
    @objc func filter(sender: UISegmentedControl){
        
    }
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfCells()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LaunchpadCell.Constants.reuseIdentifier, for: indexPath) as? LaunchpadCell else {return UICollectionViewCell()}
        cell.configure(with: presenter.viewDataForCell(at: indexPath.item))
    
        return cell
    }
}

extension LaunchpadListViewController{
    enum Constants{
        static let verticalInset: CGFloat = 30.0
        static let horizontalInset: CGFloat = 20.0
        static let interspacing: CGFloat = 30.0
    }
}

extension LaunchpadListViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: Constants.verticalInset, left: Constants.horizontalInset, bottom: Constants.verticalInset, right: Constants.horizontalInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.safeAreaLayoutGuide.layoutFrame.width - 2 * Constants.horizontalInset
        let height = width / LaunchpadCell.Constants.widthToHeightRatio
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        Constants.interspacing
    }
}

extension LaunchpadListViewController: LaunchpadListPresenterDelegate{
    func updateCollectionView() {
        collectionView.reloadData()
    }
}
