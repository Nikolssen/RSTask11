//
//  RocketListViewController.swift
//  RSTask11
//
//  Created by Ivan Budovich on 9/9/21.
//

import UIKit


class RocketListViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(RocketCell.self, forCellWithReuseIdentifier: RocketCell.Constants.reuseIdentifier)
        
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RocketCell.Constants.reuseIdentifier, for: indexPath) as? RocketCell else {return UICollectionViewCell()}
    
    
        return cell
    }

}
