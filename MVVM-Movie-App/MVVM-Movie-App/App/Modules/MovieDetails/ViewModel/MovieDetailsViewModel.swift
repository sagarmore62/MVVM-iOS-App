//
//  MoviesDetailsViewModel.swift
//  MVVM-Movie-App
//
//  Created by Sagar More on 16/05/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import Foundation

/// View Modal for movie details page
struct MovieDetailsViewModel {
    let imagePath : String?
    let description : NSMutableAttributedString
    let overview : NSMutableAttributedString?
    let releaseData : NSMutableAttributedString?
}
