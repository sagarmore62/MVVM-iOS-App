//
//  MovieListCollectionViewCell.swift
//  MVVM-iOS
//
//  Created by Sagar More on 24/03/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import UIKit

class MovieListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgMovie : UIImageView!
    @IBOutlet weak var lblMoveName : UILabel!
    @IBOutlet weak var btnWishlist : UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgMovie.layer.masksToBounds = true
        imgMovie.layer.cornerRadius = 5.0
        imgMovie.alpha = 0.75 //to hightlight the favourite icon
    }
    
    func configureCell(_ data : MovieObjectViewModel) {
        lblMoveName.attributedText =  data.description
        if let path = data.imagePath {
            imgMovie.getImageWith(path)
        }
        btnWishlist.isSelected = WishlistService.shared.isWishlistedMovie(data)
    }
    
}
