//
//  RocketListViewController.swift
//  RSTask11
//
//  Created by Ivan Budovich on 9/9/21.
//

import UIKit


final class RocketListViewController: UICollectionViewController {

    var presenter: RocketListPresenterType!
    
    private var selectedCellIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .queenBlue
        collectionView.backgroundColor = .queenBlue
        self.collectionView.register(RocketCell.Constants.nib, forCellWithReuseIdentifier: RocketCell.Constants.reuseIdentifier)
        configureNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.fetchData()
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        selectedCellIndexPath = nil
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.reloadData()
    }
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfCells()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RocketCell.Constants.reuseIdentifier, for: indexPath) as? RocketCell else {return UICollectionViewCell()}
        cell.configure(with: presenter.viewDataForCell(at: indexPath.item))
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCellIndexPath = indexPath
        presenter.showDetailsForCell(at: indexPath.item)
    }
    func configureNavigationBar(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: .bidirectionalArrow, style: .plain, target: self, action: #selector(showSortOptions))
    }
    
    @objc func showSortOptions(){
        let alertController = UIAlertController(title: "Choose your option", message: nil, preferredStyle: .actionSheet)
        alertController.view.tintColor = .coral
        let launchDateAlertAction = UIAlertAction(title: "First launch", style: .default) { [presenter] _ in
            presenter?.sort(by: .firstLaunch)
        }
        let launchCostAlertAction = UIAlertAction(title: "Launch cost", style: .default) { [presenter] _ in
            presenter?.sort(by: .launchCost)
        }
        let successRateAlertAction = UIAlertAction(title: "Success rate", style: .default) { [presenter] _ in
            presenter?.sort(by: .success)
        }
        let cancelAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        cancelAlertAction.setValue(UIColor(red: 0.922, green: 0.341, blue: 0.341, alpha: 1), forKey: "titleTextColor")
        alertController.addAction(launchDateAlertAction)
        alertController.addAction(launchCostAlertAction)
        alertController.addAction(successRateAlertAction)
        alertController.addAction(cancelAlertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    var selectedCell: UICollectionViewCell? {
        if let indexPath = selectedCellIndexPath {
            return collectionView.cellForItem(at: indexPath)
        }
        return nil
    }

}

extension RocketListViewController{
    enum Constants{
        static let verticalInset: CGFloat = 30.0
        static let horizontalInset: CGFloat = 20.0
        static let interspacing: CGFloat = 30.0
    }
}

extension RocketListViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: Constants.verticalInset, left: Constants.horizontalInset, bottom: Constants.verticalInset, right: Constants.horizontalInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.safeAreaLayoutGuide.layoutFrame.width - 2 * Constants.horizontalInset
        let height = width / RocketCell.Constants.widthToHeightRatio
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        Constants.interspacing
    }
}

extension RocketListViewController: RocketListPresenterDelegate{
    func updateCollectionView() {
        collectionView.reloadData()
    }
}
