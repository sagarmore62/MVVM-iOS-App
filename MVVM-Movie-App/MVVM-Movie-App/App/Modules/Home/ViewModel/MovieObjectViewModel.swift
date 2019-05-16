//
//  MovieObjectViewModel.swift
//  MVVM-Movie-App
//
//  Created by Sagar More on 15/05/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import Foundation

struct MovieObjectViewModel {
    
    var imagePath : String?
    let description : NSMutableAttributedString
    let movieId : Int
    let overview : String?
    let releaseDate : String?
    
    /// Init method, which transforms model into view model
    /// - Parameter model: MovieObject model
    init(_ model : MovieObject) {
        //format full image path
        if let path = model.posterPath {
            imagePath = EndPoint.domainImage + "w300" + path
        }
        movieId = model.id
        overview = model.overview
        releaseDate = model.releaseDate
        
        if let title = model.title {
            //format description of movie as : movie title (vote average)
            let attributedString = NSMutableAttributedString(string: title)
            attributedString.addAttributes([NSAttributedString.Key.font : AppTheme.Font.bold], range: NSMakeRange(0, attributedString.length))
            if let vote = model.voteAverage?.description {
                let attributedVote = NSAttributedString(string: " (" + vote  + ")", attributes: [NSAttributedString.Key.font : AppTheme.Font.regular])
                attributedString.append(attributedVote)
            }
            description = attributedString
        } else {
            description = NSMutableAttributedString()
        }
    }
    
    /// Method formats the data usable by movie details page
    /// - Returns: MovieDetailsViewModel
    func getMovieDetailsFormattedData() ->MovieDetailsViewModel {
        let overViewAttr = getAttributedString("Overview", subTitle: overview)
        let releaseAttr = getAttributedString("Release Data", subTitle: releaseDate)
        return MovieDetailsViewModel.init(imagePath: imagePath, description: description, overview: overViewAttr, releaseData: releaseAttr)
    }
    
    private func getAttributedString(_ title : String, subTitle : String?) -> NSMutableAttributedString? {
        guard let sub = subTitle else {
            return nil
        }
        let mainAttr = NSMutableAttributedString(string: title + " : ")
        mainAttr.addAttributes([NSMutableAttributedString.Key.font : AppTheme.Font.bold], range: NSMakeRange(0, mainAttr.length))
        let subAttr = NSAttributedString(string: sub, attributes : [NSMutableAttributedString.Key.font : AppTheme.Font.regular])
        mainAttr.append(subAttr)
        return mainAttr
    }
}
