//
//  HomeViewController+UICollectionViewDelegate.swift
//  MVVM-Movie-App
//
//  Created by Sagar More on 16/05/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import UIKit

// MARK: - Collection view delegate methods
extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getListCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellData = viewModel.getCellDataWith(indexPath.row)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MovieListCollectionViewCell
        cell.btnWishlist.tag = indexPath.row
        cell.btnWishlist.addTarget(self, action: #selector(onWishlistClicked(_:)), for: .touchUpInside)
        cell.configureCell(cellData)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.getNextPageData(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellData = viewModel.getCellDataWith(indexPath.row)
        if let vc = storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.movieDetails) as? MovieDetailsViewController {
            vc.viewModel = cellData.getMovieDetailsFormattedData()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
