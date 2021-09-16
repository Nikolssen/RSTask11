//
//  LaunchListViewController.swift
//  RSTask11
//
//  Created by Ivan Budovich on 9/10/21.
//

import UIKit

import UIKit

final class LaunchListViewController: UICollectionViewController {

    var presenter: LaunchListPresenterType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .queenBlue
        collectionView.backgroundColor = .queenBlue
        self.collectionView.register(LaunchCell.Constants.nib, forCellWithReuseIdentifier: LaunchCell.Constants.reuseIdentifier)
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
        segmentedControl.insertSegment(withTitle: "Past", at: 1, animated: false)
        segmentedControl.insertSegment(withTitle: "Future", at: 2, animated: false)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(filter(sender:)), for: .valueChanged)
        self.navigationItem.titleView = segmentedControl
    }
    @objc func showSortOptions(){
        let alertController = UIAlertController(title: "Choose your option", message: nil, preferredStyle: .actionSheet)
        alertController.view.tintColor = .coral
        let launchDateAlertAction = UIAlertAction(title: "Launch date", style: .default) { [presenter] _ in
            presenter?.sort(by: .launchDate)
        }
        let titleAlertAction = UIAlertAction(title: "Title", style: .default) { [presenter] _ in
            presenter?.sort(by: .title)
        }
        let numberAlertAction = UIAlertAction(title: "Number", style: .default) { [presenter] _ in
            presenter?.sort(by: .number)
        }
        let cancelAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        cancelAlertAction.setValue(UIColor(red: 0.922, green: 0.341, blue: 0.341, alpha: 1), forKey: "titleTextColor")
        alertController.addAction(launchDateAlertAction)
        alertController.addAction(titleAlertAction)
        alertController.addAction(numberAlertAction)
        alertController.addAction(cancelAlertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func filter(sender: UISegmentedControl){
        switch sender.selectedSegmentIndex {
        case 0:
            presenter.filter(by: .all)
        case 1:
            presenter.filter(by: .past)
        case 2:
            presenter.filter(by: .future)
        default:
            break
        }
    }
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfCells()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LaunchCell.Constants.reuseIdentifier, for: indexPath) as? LaunchCell else {return UICollectionViewCell()}
        cell.configure(with: presenter.viewDataForCell(at: indexPath.item))
    
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.showDetailsForCell(at: indexPath.item)
    }
}

extension LaunchListViewController{
    enum Constants{
        static let verticalInset: CGFloat = 30.0
        static let horizontalInset: CGFloat = 20.0
        static let interspacing: CGFloat = 30.0
    }
}

extension LaunchListViewController: UICollectionViewDelegateFlowLayout{
    
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

extension LaunchListViewController: LaunchListPresenterDelegate{
    func updateCollectionView() {
        collectionView.reloadData()
    }
}
